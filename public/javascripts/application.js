// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// IE fix
document.createElement('header');
document.createElement('nav');
document.createElement('article');
document.createElement('section');
document.createElement('aside');
document.createElement('hgroup');
document.createElement('footer');

document.observe("dom:loaded", function() {
	$$(".main_nav li:not(.first, .last)").each(function(el) {
		activeEl = Builder.node("div", { className: "hover" });
		activeEl.hide();
		el.appendChild(activeEl);
	});
	
	$$(".main_nav li:not(.first, .last)").each(function(el) {
		el.observe("mouseenter", function() {
      queue = Effect.Queues.get("leave"+this.className);
      queue.each(function(effect) { effect.cancel(); });
			this.down(".hover").appear({duration: 0.7, queue: {scope: "enter"+this.className}});
		});
		el.observe("mouseleave", function() {
      queue = Effect.Queues.get("enter"+this.className);
      queue.each(function(effect) { effect.cancel(); });
			this.down(".hover").fade({queue: {scope: "leave"+this.className}});
		});
	});

  // Disable context menu
  /*
  document.body.observe("contextmenu", function(e){
      e.stop();
  });*/
  
});
