#!/bin/bash

DEB_PACKAGE="counter-v2.0.0.deb"

# Check if the deb package exists
if [ ! -f "$DEB_PACKAGE" ]; then
    echo "$DEB_PACKAGE not found. Building the package..."
    ./bedBuild.sh
else
    echo "$DEB_PACKAGE already exists. Skipping build."
fi

# Run lintian on the .deb package
lintian "$DEB_PACKAGE"
