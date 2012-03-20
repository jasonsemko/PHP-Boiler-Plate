var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY_PROCUREMENT = SIGMA.THIRD_PARTY_PROCUREMENT || {};
SIGMA.THIRD_PARTY_PROCUREMENT.search_results = SIGMA.THIRD_PARTY_PROCUREMENT.search_results || {};

$.extend(SIGMA.THIRD_PARTY_PROCUREMENT.search_results, function() {
	
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
	SIGMA.THIRD_PARTY_PROCUREMENT.search_results.init();	
});