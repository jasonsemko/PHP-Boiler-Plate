var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY_PROCUREMENT = SIGMA.THIRD_PARTY_PROCUREMENT || {};
SIGMA.THIRD_PARTY_PROCUREMENT.global = SIGMA.THIRD_PARTY_PROCUREMENT.global || {};

$.extend(SIGMA.THIRD_PARTY_PROCUREMENT.global, function() {
	
	var methods = {
		
		setup: function() {
			console.log("setup");
		}
	};
	
	return {
		init: function() {
			methods.setup();
		}
	}
	
}.call(SIGMA.THIRD_PARTY_PROCUREMENT));


$(window).load(function(){
	SIGMA.THIRD_PARTY_PROCUREMENT.global.init();	
});