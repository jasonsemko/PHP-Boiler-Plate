var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.global = SIGMA.THIRD_PARTY.global || {};

$.extend(SIGMA.THIRD_PARTY.global, function() {
	
	var methods = {
		
		setup: function() {
			
			this.colorboxSetup();
			this.productModule();
			this.searchAutocomplete();
		},
		
		colorboxSetup: function() {
			
			$("a.colorbox").colorbox({
				opacity: 0.8
			});
		},
		
		productModule: function() {
			
			var products = document.getElementsByTagName("div"),
			i, max, link, product;
			
			for(i=0; max=products.length, i<max; i++) {				
				if(products[i].className === "product") {
					
					product = products[i];
					link = product.attributes.title.nodeValue;
					
					this.fastClick(product, function(e){
						
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
		
		fastClick: function(obj, func) {
			if($.browser.msie && $.browser.version <= 8) {
				obj.attachEvent("onclick", func);
			} else {
				obj.addEventListener("click", func, false);
			}
		},
		
		searchAutocomplete: function() {

			$("input", ".search").on("keyup", function() {
				
				var s = document.getElementById("main-search");
				
				if(s.value.length > 3) {
					$(".autocomplete").fadeIn();
				} else {
					$(".autocomplete").fadeOut();
				}
			});
		}
	};
	
	return {
		init: function() {
			methods.setup();
		},
		fastClick: function(o,f) {
			methods.fastClick(o,f);
		}
	}
	
}.call(SIGMA.THIRD_PARTY));


$(window).load(function(){
	SIGMA.THIRD_PARTY.global.init();
});