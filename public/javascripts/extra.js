jQuery(function(){
			jQuery('.sf-menu').superfish({
			
            animation:   {opacity:'show',height:'show'},  // fade-in and slide-down animation 
            
            autoArrows:  false,                           // disable generation of arrow mark-up 
            dropShadows: false                            // disable drop shadows      
			});
		});
		
jQuery(document).ready(function() {
			jQuery('.slideshow').after('<div id="nav">')
				
	 		jQuery("a[rel^='prettyPhoto'], a[rel^='lightbox']").prettyPhoto({
			"theme": 'light_square' 																
	});
	  });
	  
Cufon.replace('.logo span, h1, h2, h3, h4 , h5, h6, .learnmore, .fresh_button, .comment-reply-link, .slide_button, .page_title .bold p');	
