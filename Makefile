# Makefile to start Titanium Mobile project from the command line.
# More info at http://github.com/guilhermechapiewski/titanium-jasmine

PROJECT_NAME=NuxeoWorld
PROJECT_ROOT=$(shell pwd)

run-iphone:
	@DEVICE_TYPE=iphone make run

test-iphone:
	@DEVICE_TYPE=iphone make test

run-ipad:
	@DEVICE_TYPE=ipad make run

test-ipad:
	@DEVICE_TYPE=ipad make test

run:
	@if [ "${DEVICE_TYPE}" == "" ]; then\
		echo "Please run \"make run-[iphone|ipad]\" instead.";\
		exit 1;\
	fi
	@mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	@cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	@mkdir -p ${PROJECT_ROOT}/Resources/test/
	@echo "" > ${PROJECT_ROOT}/Resources/test/enabled.js
	@make launch-titanium

test:
	@if [ "${DEVICE_TYPE}" == "" ]; then\
		echo "Please run \"make test-[iphone|ipad]\" instead.";\
		exit 1;\
	fi
	@mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	@cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	@mkdir -p ${PROJECT_ROOT}/Resources/test/
	@echo "sampleapp.tests_enabled = true;" > ${PROJECT_ROOT}/Resources/test/enabled.js
	@make launch-titanium

clean:
	@rm -rf ${PROJECT_ROOT}/build/iphone/*
	@mkdir -p ${PROJECT_ROOT}/build/iphone/
	@echo "Deleted: ${PROJECT_ROOT}/build/iphone/*"

launch-titanium:
	@echo "Building with Titanium... (DEVICE_TYPE:${DEVICE_TYPE})"
	@mkdir -p ${PROJECT_ROOT}/build/iphone/
	@PROJECT_NAME=${PROJECT_NAME} PROJECT_ROOT=${PROJECT_ROOT} DEVICE_TYPE=${DEVICE_TYPE} bash ${PROJECT_ROOT}/bin/titanium.sh
