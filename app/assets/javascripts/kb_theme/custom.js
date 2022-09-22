$(document).ready(function() {
  $('.res-betslip-btn button').click(function() {
    $('.right-side').slideToggle("fast");
  });
});

$(document).ready(function() {
  $('.close-betslip').click(function() {
    $('.right-side').slideToggle("fast");
  });
});

$(document).ready(function() {
  $('.menu-resp').click(function() {
    $('.left-side-nav').slideToggle("fast");
  });
});

$(document).ready(function() {
  $('.close-left').click(function() {
    $('.left-side-nav').slideToggle("fast");
  });
});

$(document).ready(function() {
      var owl = $('.owl-carousel');
      owl.owlCarousel({
        margin: 10,
        nav: true,
        autoplay : 200,
        dots: false,
        responsive: {
          0: {
            items: 1
          },
          600: {
            items: 2
          },
          1200: {
            items: 3
          },
          1360: {
            items: 4
          }
        }
      })
    })

if ($(window).width() > 991) {
$(window).scroll(function(e){ 
  var $el = $('.static-menu'); 
  var isPositionFixed = ($el.css('position') == 'sticky');
  if ($(this).scrollTop() > 160 && !isPositionFixed){ 
    $el.css({'position': 'sticky', 'top': '0px', 'left': '10px'});
    $('.static-menu') .css({'height': (($(window).height()) - 0)+'px'}); 
  }

  if ($(this).scrollTop() < 160 && isPositionFixed){
    $el.css({'position': 'static', 'top': '0px', 'left': '0px'}); 
    $('.static-menu') .css({'height': (($(window).height()) - 230)+'px'});
  } 
});
}