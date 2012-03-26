var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.search_results = SIGMA.THIRD_PARTY.search_results || {};

$.extend(SIGMA.THIRD_PARTY.search_results, function() {
	
	var methods = {
		
		setup: function() {
			this.togglePricing();
			this.toggleFiltering();
		},
		
		
		togglePricing: function() {
			var a = document.getElementById("pricing-expand-collapse");
			
			$("#pricing-expand-collapse").toggle(function() {
				var vac = $(this).closest(".vancomycin");
				vac.find(".vancomycin-top").removeClass("collapsed").addClass("expanded");
				vac.find(".pricing").show();
			}, function() {
				var vac = $(this).closest(".vancomycin");
				vac.find(".vancomycin-top").removeClass("expanded").addClass("collapsed");
				vac.find(".pricing").hide();
			});
		},
		
		
		toggleFiltering: function() {
		    $(".RefinementDimensionHeader").each(function(index) {
		        var refineBox = jQuery(this)
		                            .closest(".RefinementDimension")
		                            .find(".RefinementDimensionText");
                            
		        jQuery(this).toggle(function() {
            
		            options = jQuery.browser.version == "6.0" && jQuery.browser.msie ? "" :
		            {
		                "background-color" : "white",
		                "height" : "200px",
		                "overflow" : "auto"
		            };
            
		            refineBox.find("div").length > 10 ? refineBox.css(options) : "";
            
		            refineBox
		                .slideDown()
		                .end()
		                .find(".results-sprite")
		                .css("background-position","-69px -88px");
                
		        }, function() {
		            refineBox
		                .slideUp()
		                .end()
		                .find(".results-sprite")
		                .css("background-position","-88px -88px");
		        });
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
	SIGMA.THIRD_PARTY.search_results.init();	
});

			// SIGMA.THIRD_PARTY.global.fastClick(a, function(e) {
			// 				
			// 				var children = this.parentNode.parentNode.childNodes, 
			// 				i,max;
			// 				
			// 				for(i=0; max=children.length,i<max; i++ ) {
			// 					
			// 					var nodeStyle = children[i].style,
			// 						nodeClass = children[i].className;
			// 					
			// 					//Switch Pricing IMage
			// 					if(nodeClass === "vancomycin-top collapsed") {
			// 						nodeStyle.backgroundPosition = "0px -170px";
			// 						children[i].className = "vancomycin-top expanded";
			// 						continue;
			// 						
			// 					} 
			// 					if(nodeClass === "vancomycin-top expanded") {
			// 						children[i].style.backgroundPosition = "0px 0px";
			// 						children[i].className = "vancomycin-top collapsed";
			// 						continue;
			// 					}
			// 					
			// 					
			// 					//Show or Hide Pricing
			// 					if(nodeClass === "pricing") {
			// 						nodeStyle.display = nodeStyle.display !== "block" ? "block" : "none";				
			// 					}	
			// 				}
			// 			});