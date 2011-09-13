var Codestrong = {
	datetime: {},
    settings: {},
    __isLargeScreen: undefined,
    __isAndroid: undefined,
    navWindow: undefined,
    navGroup: undefined,
    tabBarHeight: 36
};

Object.create = function (o) {
    var F = function () {};
    F.prototype = 0;
    return new F();
};

(function() {
	Codestrong.isLargeScreen = function() {
		if (Codestrong.__isLargeScreen === undefined) {
			Codestrong.__isLargeScreen = (Ti.Platform.displayCaps.platformWidth >= 600);
		}
		return Codestrong.__isLargeScreen;
	};
	
	Codestrong.isAndroid = function() {
		if (Codestrong.__isAndroid === undefined) {
			Codestrong.__isAndroid = (Ti.Platform.osname == 'android');
		}
		return Codestrong.__isAndroid;
	}
})();