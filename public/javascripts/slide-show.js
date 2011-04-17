var SlideShow = Class.create({
	
	/* Constructor */
	initialize: function(containerId, imageUrls) {
		this.container = $(containerId);
		if (this.container == null)
			throw "Container not found! Container id: " + containerId;
			
		this.busyIcon = Builder.node("div", { className: "busy-icon" });
		this.busyIcon.hide();		
		this.container.appendChild(this.busyIcon);		
		
		this.preloadImages(imageUrls);
	},
	
	preloadImages: function(imageUrls) {
		/* Display loading indicator */
		this.busyIcon.show();
	
		this.currentSlideIndex = -1;
		this.images = new Array();
		this.slides = new Array();
		
		for (i = 0; i < imageUrls.length; i++) {
			var image = this.preloadImage(imageUrls[i]);
			this.images.push(image);
		}
	},
	
	preloadImage: function(imageUrl) {
		w = this.container.getWidth();
		h = this.container.getHeight();
		
		var image = new Image(w, h);
		image.src = imageUrl;				
		ss = this;
								
		image.onload = function() {									
			slide = ss.createSlide(ss.container, image);
			
			/* This is the first loaded image? */
			if (ss.currentSlideIndex == -1) {								
				ss.currentSlideIndex = 0;
				ss.busyIcon.hide();
				
				// Show first slide
				slide.style.left = 0;
				slide.appear();
			}			
		};
				
		return image;
	},
	
	createSlide: function(container, image) {
		var slide = Builder.node("div", {className: "slide-container"}, image);
		// Place slide behind the right border
		slide.style.left = container.getWidth() + "px";
		slide.hide();
		
		this.slides.push(slide);
		this.container.appendChild(slide);
		return slide;
	},
		
	run: function() {		
		ss = this;
		left = this.container.getWidth();
			
		new PeriodicalExecuter(
			function () {
				if (ss.slides.length >= 2) {
					currentSlide = ss.slides[ss.currentSlideIndex];			

					// Determine the next slide
					if (ss.currentSlideIndex < ss.slides.length - 1) {
						nextSlide = ss.slides[ss.currentSlideIndex + 1];
						ss.currentSlideIndex++;
					} else {
						nextSlide = ss.slides[0];
						ss.currentSlideIndex = 0;
					}

					// Place current slide on the top
					currentSlide.style.zIndex = 1;					
					currentSlide.fade({
						afterFinish: function() { 
							currentSlide.style.left = left + "px"; 
							currentSlide.style.zIndex = 0; 
						}
					});
					// Show next slide from the right
					new Effect.Move(nextSlide, {x: 0, mode: 'absolute'});					
					nextSlide.appear();
				} 				
			},  5);
	}	
});

