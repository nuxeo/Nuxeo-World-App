# Makefile to start Titanium Mobile project from the command line.
# More info at http://github.com/guilhermechapiewski/titanium-jasmine

PROJECT_NAME=NuxeoWorld
PROJECT_ROOT=$(shell pwd)

run-iphone:
	DEVICE_TYPE=iphone make run

test-iphone:
	DEVICE_TYPE=iphone make test

run-ipad:
	DEVICE_TYPE=ipad make run

test-ipad:
	DEVICE_TYPE=ipad make test

run:
	if [ "${DEVICE_TYPE}" == "" ]; then\
		echo "Please run \"make run-[iphone|ipad]\" instead.";\
		exit 1;\
	fi
	mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	mkdir -p ${PROJECT_ROOT}/Resources/test/
	echo "" > ${PROJECT_ROOT}/Resources/test/enabled.js
	make launch-titanium

test:
	if [ "${DEVICE_TYPE}" == "" ]; then\
		echo "Please run \"make test-[iphone|ipad]\" instead.";\
		exit 1;\
	fi
	mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	mkdir -p ${PROJECT_ROOT}/Resources/test/
	echo "sampleapp.tests_enabled = true;" > ${PROJECT_ROOT}/Resources/test/enabled.js
	make launch-titanium

clean:
	rm -rf ${PROJECT_ROOT}/build/iphone/*
	rm -rf ${PROJECT_ROOT}/build/android/*
	mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	echo "Deleted: ${PROJECT_ROOT}/build/iphone/*"
	echo "Deleted: ${PROJECT_ROOT}/build/android/*"
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png

launch-titanium:
	echo "Building with Titanium... (DEVICE_TYPE:${DEVICE_TYPE})"
	mkdir -p ${PROJECT_ROOT}/build/iphone/
	PROJECT_NAME=${PROJECT_NAME} PROJECT_ROOT=${PROJECT_ROOT} DEVICE_TYPE=${DEVICE_TYPE} bash ${PROJECT_ROOT}/bin/titanium.sh

#
# Specific part written by Nuxeo

SDK_VERSION=1.7.2
IOS_VERSION=4.3
DIST_UUID=D3023DD0-FB15-46A4-89B8-E2ECC08C919B
TEST_UUID=D7E10EDC-5666-47CE-98CA-4F976F6B3569
DEV_ID=Stefane Fermigier (N6XFBZ44WD)
APP_ID=com.nuxeo.nuxeoworld
APP_NAME=NuxeoWorld
DIST_CERT=Nuxeo
SDK_HOME=/Library/Application Support/Titanium/mobilesdk/osx/$(SDK_VERSION)/
IOS_BUILDER=$(SDK_HOME)/iphone/builder.py
ANDROID_BUILDER=$(SDK_HOME)/android/builder.py
ANDROID_HOME=$(HOME)/apps/android-sdk-mac_x86

HERE=$(shell pwd)

install-ios:
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	python "$(IOS_BUILDER)" install "$(IOS_VERSION)" $(HERE) \
		    "$(APP_ID)" "$(APP_NAME)" $(TEST_UUID) "$(DEV_ID)" iphone

test-android:
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png
	python "$(ANDROID_BUILDER)" simulator "$(APP_NAME)" "$(ANDROID_HOME)" \
		    "$(HERE)" "$(APP_ID)" 8 HVGA

distribute-android:
	python "$(ANDROID_BUILDER)" distribute "$(APP_NAME)" "$(ANDROID_HOME)" \
		    "$(HERE)" "$(APP_ID)"

install-android:
	python "$(ANDROID_BUILDER)" install "$(APP_NAME)" "$(ANDROID_HOME)" \
		    "$(HERE)" "$(APP_ID)" 8

