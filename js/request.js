var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.request = SIGMA.THIRD_PARTY.request || {};

$.extend(SIGMA.THIRD_PARTY.request, function() {
	
	var methods = {
		
		setup: function() {
			
		}
	};
	
	return {
		init: function() {
			methods.setup();
		}
	}
	
}.call(SIGMA.THIRD_PARTY));


$(window).load(function(){
	SIGMA.THIRD_PARTY.request.init();	
});