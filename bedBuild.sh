#!/bin/sh

TEMP_DIR=temp

echo "Starting deb package build"

echo "Making temporary directory tree"
mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR/lib/systemd/system/
mkdir -p $TEMP_DIR/usr/local/bin/
mkdir -p $TEMP_DIR/DEBIAN/

echo "Copy control file for DEBIAN/"
cp src/DEBIAN/control $TEMP_DIR/DEBIAN/

echo "no conffiles for DEBIAN"

echo "Copy python script into place"
cp counter.py $TEMP_DIR/usr/local/bin/

echo "Service file into place"
cp src/counter.service $TEMP_DIR/lib/systemd/system/

sudo chmod 644 $TEMP_DIR/lib/systemd/system/counter.service

echo "Moving scripts into place"
cp src/DEBIAN/postinst $TEMP_DIR/DEBIAN/
cp src/DEBIAN/prerm $TEMP_DIR/DEBIAN/
cp src/DEBIAN/postrm $TEMP_DIR/DEBIAN/

sudo chmod +x $TEMP_DIR/DEBIAN/postinst
sudo chmod +x $TEMP_DIR/DEBIAN/prerm
sudo chmod +x $TEMP_DIR/DEBIAN/postrm

echo "Building deb file"
version=$(grep '^Version:' src/DEBIAN/control | awk '{print $2}')
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb counter-v$version.deb

echo "Complete."
