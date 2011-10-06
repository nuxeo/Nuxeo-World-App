# Makefile to start Titanium Mobile project from the command line.

PROJECT_NAME=NuxeoWorld
DIST_UUID=D3023DD0-FB15-46A4-89B8-E2ECC08C919B

SDK_VERSION=1.7.2
SDK_HOME="/Library/Application Support/Titanium/mobilesdk/osx/$(SDK_VERSION)/"
TITANIUM="$(SDK_HOME)/titanium.py"
ANDROID_HOME=$(HOME)/apps/android-sdk-mac_x86

PROJECT_ROOT=$(shell pwd)


run-iphone:
	$(TITANIUM) run --platform=iphone

run-android:
	mkdir -p build/android/bin/assets/Resources
	cp ./Resources/android/appicon.png \
		build/android/bin/assets/Resources/appicon.png
	$(TITANIUM) run --platform=android

prepare-data:
	# NOTE: -I option shouldn't be needed if CPAN configured properly
	python gen_json.py
	perl -I /Users/fermigier/.cpan/build/JSON-2.53-uATlTb/lib populate.pl
	rm Resources/main.sql
	sqlite3 Resources/main.sql < main.sql.script 
	rsync -e ssh -avz data/* root@nuxeo.org:/var/www/community.nuxeo.com/static/nuxeo-world/2011

clean:
	rm -rf ${PROJECT_ROOT}/build/iphone/*
	rm -rf ${PROJECT_ROOT}/build/android/*
	mkdir -p ${PROJECT_ROOT}/build/iphone/Resources
	echo "Deleted: ${PROJECT_ROOT}/build/iphone/*"
	echo "Deleted: ${PROJECT_ROOT}/build/android/*"
	cp ./Resources/iphone/Default.png build/iphone/Resources/Default.png

#
# More hackish and non robust part

SDK_VERSION=1.7.2
IOS_VERSION=4.3
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

