var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.index = SIGMA.THIRD_PARTY.index || {};

$.extend(SIGMA.THIRD_PARTY.index, function() {
	
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
	SIGMA.THIRD_PARTY.index.init();	
});