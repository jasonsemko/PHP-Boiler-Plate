var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.antibiotics=SIGMA.THIRD_PARTY.antibiotics||{};
$.extend(SIGMA.THIRD_PARTY.antibiotics,function(){var a={setup:function(){this.openFilters()},openFilters:function(){var b=$.Deferred();
b.done(function(){$(".mechanisms").trigger("click")},this.updateContent);b.resolve()},updateContent:function(){$(".mechanisms").click(function(l){var k=document.getElementById("mechanisms-1").style,o=document.getElementById("mechanisms-2").style,m=document.getElementsByTagName("ul"),b=document.getElementsByTagName("div"),f='url("../img/antibiotics/results-dropdown.png")',d='url("../img/antibiotics/results-dropdown-2.png")',h,g,n;
k.display=k.display==="none"?"block":"none";o.display=o.display==="none"?"block":"none";for(h=0;n=m.length,h<n;
h++){if(m[h].className==="list"){m[h].style.display=m[h].style.display==="none"?"block":"none";var c=m[h].parentNode.childNodes;
for(g=0;g<c.length;g++){if(c[g].className==="no-selections"){c[g].style.display=c[g].style.display==="block"?"none":"block"
}}}}for(h=0;n=b.length,h<n;h++){if(b[h].className==="results-dropdown"){b[h].style.backgroundImage=b[h].style.backgroundImage===f?d:f
}}})}};return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.antibiotics.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.cart=SIGMA.THIRD_PARTY.cart||{};
$.extend(SIGMA.THIRD_PARTY.cart,function(){var a={setup:function(){}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.cart.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.global=SIGMA.THIRD_PARTY.global||{};$.extend(SIGMA.THIRD_PARTY.global,function(){var a={setup:function(){this.colorboxSetup();
this.productModule();this.searchAutocomplete()},colorboxSetup:function(){$("a.colorbox").colorbox({opacity:0.8})
},productModule:function(){var f=document.getElementsByTagName("div"),c,b,d,e;for(c=0;b=f.length,c<b;
c++){if(f[c].className==="product"){e=f[c];d=e.attributes.title.nodeValue;this.fastClick(e,function(h){var g;
if($.browser.msie&&$.browser.version<=8){g=h.srcElement.nodeName}else{g=h.target.nodeName}if(g!=="A"){window.location.href=d
}})}}},fastClick:function(c,b){if($.browser.msie&&$.browser.version<=8){c.attachEvent("onclick",b)}else{c.addEventListener("click",b)
}},searchAutocomplete:function(){$("input",".search").on("keyup",function(){var b=document.getElementById("main-search");
if(b.value.length>3){$(".autocomplete").fadeIn()}else{$(".autocomplete").fadeOut()}})}};return{init:function(){a.setup()
},fastClick:function(c,b){a.fastClick(c,b)}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.global.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.index=SIGMA.THIRD_PARTY.index||{};
$.extend(SIGMA.THIRD_PARTY.index,function(){var a={setup:function(){}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.index.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.life_science=SIGMA.THIRD_PARTY.life_science||{};
$.extend(SIGMA.THIRD_PARTY.life_science,function(){var a={setup:function(){}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.life_science.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.product_detail=SIGMA.THIRD_PARTY.product_detail||{};
$.extend(SIGMA.THIRD_PARTY.product_detail,function(){var a={setup:function(){}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.product_detail.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.request=SIGMA.THIRD_PARTY.request||{};$.extend(SIGMA.THIRD_PARTY.request,function(){var a={setup:function(){}};
return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.request.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.search_results=SIGMA.THIRD_PARTY.search_results||{};
$.extend(SIGMA.THIRD_PARTY.search_results,function(){var a={setup:function(){this.togglePricing();this.toggleFiltering()
},togglePricing:function(){var b=document.getElementById("pricing-expand-collapse");$("#pricing-expand-collapse").toggle(function(){var c=$(this).closest(".vancomycin");
c.find(".vancomycin-top").removeClass("collapsed").addClass("expanded");c.find(".pricing").show()},function(){var c=$(this).closest(".vancomycin");
c.find(".vancomycin-top").removeClass("expanded").addClass("collapsed");c.find(".pricing").hide()})},toggleFiltering:function(){$(".RefinementDimensionHeader").each(function(b){var c=jQuery(this).closest(".RefinementDimension").find(".RefinementDimensionText");
jQuery(this).toggle(function(){options=jQuery.browser.version=="6.0"&&jQuery.browser.msie?"":{"background-color":"white",height:"200px",overflow:"auto"};
c.find("div").length>10?c.css(options):"";c.slideDown().end().find(".results-sprite").css("background-position","-69px -88px")
},function(){c.slideUp().end().find(".results-sprite").css("background-position","-88px -88px")})})}};
return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.search_results.init()
});