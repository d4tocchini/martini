Cufon.replace('.logo span, h1, h2, h3, h4 , h5, h6, .learnmore, .fresh_button, .comment-reply-link, .slide_button, .page_title .bold p');

$(document).ready(function() {
  Cufon.now();
  
  // slideshow
  $('.slideshow').cycle({
    fx: 'fade',
    timeout: 6000,
    pager: '#nav',
    speed: 1000,
    pagerEvent: 'click',
    pauseOnPagerHover: true,
    cleartypeNoBg: true
  }).after('<div id="nav">');
  
  // ie png fix
  if ($.system.browser.ie) {
    DD_belatedPNG.fix('.logo img, .page_title .bold .slide_button, .learnmore, .learnmore span, .fresh_button, .footer_widgets .col2 li ');
  }
  
  // sort helper
  var fixHelper = function(e, ui) {
  	ui.children().each(function() {
  		$(this).width($(this).width());
  	});
  	return ui;
  };
    
//  $("a[rel^='prettyPhoto'], a[rel^='lightbox']").prettyPhoto({
//		"theme": 'light_square' 																
//	});

  // sort tables
  $(".organizable tbody").sortable({
  	helper: fixHelper,
  	containment: 'parent',
  	opacity:0.5,
  }).disableSelection();
  
  // sort tables another way
  $("table").tablesorter(); 
  
  // login
  
  $form = $("#authentication_form");
  
  // progressively enhance buttons
  $("li.oauth_provider").each(function(index, element) {
    var li = $(element);
    var input = $("input", li);
    input.css("display", "none");
    li.css("cursor", "pointer");
    li.data("oauth", input);
    li.click(function(event) {
      event.preventDefault();
      li.data("oauth").attr("checked", "checked");
      $form.submit();
      $form.find('input[name=submit]').click();
      return false;
    });
  });
});

$(function(){
	$('.sf-menu').superfish({
    animation:   {opacity:'show',height:'show'},  // fade-in and slide-down animation 
    autoArrows:  false,                           // disable generation of arrow mark-up 
    dropShadows: false                            // disable drop shadows      
	});
});