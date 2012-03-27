var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.product_detail = SIGMA.THIRD_PARTY.product_detail || {};

$.extend(SIGMA.THIRD_PARTY.product_detail, function() {
	
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
	SIGMA.THIRD_PARTY.product_detail.init();	
});