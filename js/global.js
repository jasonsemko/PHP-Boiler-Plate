var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.global = SIGMA.THIRD_PARTY.global || {};

$.extend(SIGMA.THIRD_PARTY.global, function() {
	
	var methods = {
		
		setup: function() {
			
			this.colorboxSetup();
			this.productModule();
		},
		
		colorboxSetup: function() {
			
			$("a[rel=colorbox]").colorbox({
				opacity: 0.8
			});
		},
		
		productModule: function() {
			
			var products = document.getElementsByTagName("div"),
			i, max, link, product;
			
			for(i=0; max=products.length, i<max; i++) {				
				if(products[i].className === "product") {
					
					product = products[i];
					link = product.attributes.href.nodeValue;
					
					this.fastClick(product, function(e) {
						
						var node;
						
						if($.browser.msie && $.browser.version <= 8) {
							node = e.srcElement.nodeName;
						} else {
							node = e.target.nodeName;
						}
						
						if(node !== "A") {
							window.location.href = link;
					 	}
					});
				}
			}			
		},
		
		fastClick: function(o, f) {
			if($.browser.msie && $.browser.version <= 8) {
				o.attachEvent("onclick", f);
			} else {
				o.addEventListener("click", f);
			}
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