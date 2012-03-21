var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.global = SIGMA.THIRD_PARTY.global || {};

$.extend(SIGMA.THIRD_PARTY.global, function() {
	
	var methods = {
		
		setup: function() {
			this.colorboxSetup();
		},
		
		colorboxSetup: function() {
			
			$("a[rel=colorbox]").colorbox({
				opacity: 0.8
			});
			
		}
	};
	
	return {
		init: function() {
			methods.setup();
		}
	}
	
}.call(SIGMA.THIRD_PARTY));


$(window).load(function(){
	SIGMA.THIRD_PARTY.global.init();	
});