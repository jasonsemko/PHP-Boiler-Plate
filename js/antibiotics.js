var SIGMA = SIGMA || {};
SIGMA.THIRD_PARTY = SIGMA.THIRD_PARTY || {};
SIGMA.THIRD_PARTY.antibiotics = SIGMA.THIRD_PARTY.antibiotics || {};

$.extend(SIGMA.THIRD_PARTY.antibiotics, function() {
	
	var methods = {
		
		setup: function() {
			this.openFilters();
		},
		
		//For Prototype, initially open up first filters
		openFilters: function() {
			
			var d	=	$.Deferred();
			
			d.done(function(){
				$(".mechanisms").trigger("click");
			}, this.updateContent);
			
			d.resolve();
			
			
		},
		
		updateContent: function() {
			
			$(".mechanisms").click(function(e) {

				var one	= document.getElementById("mechanisms-1").style,
					two	= document.getElementById("mechanisms-2").style,
					ul  = document.getElementsByTagName("ul"),
					div = document.getElementsByTagName("div"),
					bg1 = 'url("../img/antibiotics/results-dropdown.png")',
					bg2 = 'url("../img/antibiotics/results-dropdown-2.png")',
					i, j, max;
					
				
				//Shuffle the product images around to mock new search results
				one.display = one.display === "none" ? "block" : "none";
				two.display = two.display === "none" ? "block" : "none";
				
				
				//Remove the filters on the left rail, change to "No selections made"
				for(i=0; max=ul.length,i<max; i++) {
					if(ul[i].className === "list") {
						ul[i].style.display = ul[i].style.display === "none" ? "block" : "none";
						var child = ul[i].parentNode.childNodes;
						for(j=0; j<child.length; j++) {
							if(child[j].className === "no-selections") {
								child[j].style.display = child[j].style.display === "block" ? "none" : "block";
							}
						}
					}
				}
				
				//Mock change the result count
				for(i=0; max=div.length,i<max; i++) {
					if(div[i].className === "results-dropdown") {
						div[i].style.backgroundImage = div[i].style.backgroundImage === bg1 ? bg2 : bg1;
					}
				}
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
	SIGMA.THIRD_PARTY.antibiotics.init();	
});