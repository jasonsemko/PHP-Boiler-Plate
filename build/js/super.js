var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.antibiotics=SIGMA.THIRD_PARTY.antibiotics||{};
$.extend(SIGMA.THIRD_PARTY.antibiotics,function(){var a={setup:function(){console.log("setup")}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.antibiotics.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.cart=SIGMA.THIRD_PARTY.cart||{};$.extend(SIGMA.THIRD_PARTY.cart,function(){var a={setup:function(){console.log("setup")
}};return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.cart.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.global=SIGMA.THIRD_PARTY.global||{};
$.extend(SIGMA.THIRD_PARTY.global,function(){var a={setup:function(){this.colorboxSetup();this.productModule()
},colorboxSetup:function(){$("a.colorbox").colorbox({opacity:0.8})},productModule:function(){var f=document.getElementsByTagName("div"),c,b,d,e;
for(c=0;b=f.length,c<b;c++){if(f[c].className==="product"){e=f[c];d=e.attributes.title.nodeValue;this.fastClick(e,function(h){var g;
if($.browser.msie&&$.browser.version<=8){g=h.srcElement.nodeName}else{g=h.target.nodeName}if(g!=="A"){window.location.href=d
}})}}},fastClick:function(c,b){if($.browser.msie&&$.browser.version<=8){c.attachEvent("onclick",b)}else{c.addEventListener("click",b)
}}};return{init:function(){a.setup()},fastClick:function(c,b){a.fastClick(c,b)}}}.call(SIGMA.THIRD_PARTY));
$(window).load(function(){SIGMA.THIRD_PARTY.global.init()});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};
SIGMA.THIRD_PARTY.index=SIGMA.THIRD_PARTY.index||{};$.extend(SIGMA.THIRD_PARTY.index,function(){var a={setup:function(){}};
return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.index.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.life_science=SIGMA.THIRD_PARTY.life_science||{};
$.extend(SIGMA.THIRD_PARTY.life_science,function(){var a={setup:function(){console.log("setup")}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.life_science.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.product_detail=SIGMA.THIRD_PARTY.product_detail||{};
$.extend(SIGMA.THIRD_PARTY.product_detail,function(){var a={setup:function(){console.log("setup")}};return{init:function(){a.setup()
}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.product_detail.init()});var SIGMA=SIGMA||{};
SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.request=SIGMA.THIRD_PARTY.request||{};$.extend(SIGMA.THIRD_PARTY.request,function(){var a={setup:function(){console.log("setup")
}};return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.request.init()
});var SIGMA=SIGMA||{};SIGMA.THIRD_PARTY=SIGMA.THIRD_PARTY||{};SIGMA.THIRD_PARTY.search_results=SIGMA.THIRD_PARTY.search_results||{};
$.extend(SIGMA.THIRD_PARTY.search_results,function(){var a={setup:function(){this.togglePricing()},togglePricing:function(){var b=document.getElementById("pricing-expand-collapse");
$("#pricing-expand-collapse").toggle(function(){var c=$(this).closest(".vancomycin");c.find(".vancomycin-top").removeClass("collapsed").addClass("expanded");
c.find(".pricing").show()},function(){var c=$(this).closest(".vancomycin");c.find(".vancomycin-top").removeClass("expanded").addClass("collapsed");
c.find(".pricing").hide()})}};return{init:function(){a.setup()}}}.call(SIGMA.THIRD_PARTY));$(window).load(function(){SIGMA.THIRD_PARTY.search_results.init()
});