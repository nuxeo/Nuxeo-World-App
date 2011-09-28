Building
========

You need Titanium Studio to build. Simply open from the Studio.

If (like me) you don't like Studio, you can build, test and provision
on your own device using make.

Type "make prepare-data" also to create data from two CSV files
containing infos about talks and speakers.

Issues, bugs and workarounds
============================

The "october" month is hardcoded in two places of the source. This is
inherited from the Codestrong application which did hardcode the
"september" month instead.

To build for upload on the App Store, Titanium Studio doesn't work and I
don't know the right way to do it using the titanium scripts. Only way I
found was to open the .xcodeproj file in XCode, then build from XCode.
This is not completely trivial either, as the official documentation is
about XCode 3, and many things have changed since. For some hints, look at:

http://developer.apple.com/library/ios/#technotes/tn2250/_index.html#//apple_ref/doc/uid/DTS40009933-CH1-TNTAG16

A currently unsolved issue it Android build: neither the builds from
Titanium nor from the command-line tools seem to work on my simulator.

