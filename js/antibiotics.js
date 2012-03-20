var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY_PROCUREMENT = SIGMA.THIRD_PARTY_PROCUREMENT || {};
SIGMA.THIRD_PARTY_PROCUREMENT.antibiotics = SIGMA.THIRD_PARTY_PROCUREMENT.antibiotics || {};

$.extend(SIGMA.THIRD_PARTY_PROCUREMENT.antibiotics, function() {
	
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
	SIGMA.THIRD_PARTY_PROCUREMENT.antibiotics.init();	
});