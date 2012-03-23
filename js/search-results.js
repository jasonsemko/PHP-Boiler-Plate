var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.search_results = SIGMA.THIRD_PARTY.search_results || {};

$.extend(SIGMA.THIRD_PARTY.search_results, function() {
	
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
	
}.call(SIGMA.THIRD_PARTY));


$(window).load(function(){
	SIGMA.THIRD_PARTY.search_results.init();	
});