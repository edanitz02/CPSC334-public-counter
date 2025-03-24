build:
	echo "Building project..."

test:
	echo "Running tests..."
	sudo service counter start
	sudo service counter stop
	python3 -m pytest counterTest.py
	sudo service counter start

clean:
	echo "Cleaning up..."
	sudo chmod +x ./clean.sh
	./clean.sh

run:
	echo "Running the project..."

build-deb:
	echo "Building .deb package..."
	sudo chmod +x ./bedBuild.sh
	./bedBuild.sh
	sudo ls -l /lib/systemd/system/counter.service
	echo "good"

lint-deb:
	echo "Linting the .deb package..."
	sudo chmod +x ./lint.sh
	./lint.sh

