$(function() {
  $('#basic').flagStrap();

  $('#origin').flagStrap({
    placeholder: {
        value: "",
        text: "Country of origin"
    }
  });

  $('#options').flagStrap({
    countries: {
        "AU": "Australia",
        "GB": "United Kingdom",
        "US": "United States"
    },
    buttonSize: "btn-sm",
    buttonType: "btn-info",
    labelMargin: "10px",
    scrollable: false,
    scrollableHeight: "350px"
  });

  $('#advanced').flagStrap({
    buttonSize: "btn-lg",
    buttonType: "btn-primary",
    labelMargin: "20px",
    scrollable: false,
    scrollableHeight: "350px",
    onSelect: function (value, element) {
      console.log(element);
    }
  });

  setScrollator($('.bet-slip-content'));

  $( "#long-term, #bet-slip" ).click(function() {
    $( "body" ).addClass( "overflow-hidden" );
  });

  $( ".close" ).click(function() {
    $( "body" ).removeClass( "overflow-hidden" );
  });

  preloadActiveOutcomesFromBetslip();
});

function setScrollator(element) {
  var $scrollable_div1 = element;
  if ($scrollable_div1.data('scrollator') === undefined) {
    $scrollable_div1.scrollator({
      preventPropagation: true
    });
  }
}

function toggleCountryDropdown(sport_id, id) {
  $( "#sport-"+sport_id+"-country-"+id+"" ).click(function() {
    $( "#sport-"+sport_id+"-country-"+id+"-list-show" ).slideToggle( "slow", function() {
    });
    if($(this).attr("class") == "abc"){
      $(this).removeClass("abc");
      $(this).addClass("zyx");
    }else{
      $(this).removeClass("zyx");
      $(this).addClass("abc");
    }
  });
}

function toggleSportsDropwon(id) {
  $( "#sport-"+id+"" ).click(function() {
    $( "#sport-"+id+"-country-list" ).slideToggle( "slow", function() { });
  });
}

// $(document).ready(function(){
//   $('.bg-image').css('height', $(window).height());
//   // Comma, not colon ----^
// });

// $(window).resize(function(){
//   $('.bg-image').css('height', $(window).height());
//   // Comma, not colon ----^
// });

$(document).ready(function() {
  $(window).trigger('resize');
});

$(document).ready(function() {
  var owl = $('.owl-carousel');
  owl.owlCarousel({
    items: 1,
    loop: true,
    autoplay: true,
    autoplayTimeout: 5000,
    autoplayHoverPause: true
  });
  $('.play').on('click', function() {
    owl.trigger('play.owl.autoplay', [1000])
  })
  $('.stop').on('click', function() {
    owl.trigger('stop.owl.autoplay')
  });
})

function convertUtcInToLocalTime(utc_date, format) {
  return moment.utc(utc_date, "YYYY-DD-MM HH:mm:ss").local().format(format);
}

function commonLoaderAjax(url) {
  $.ajax(url, {
    type: "get",
    beforeSend: function() {
      setTimeout(function(){ 
        show_spinner();
      }, 0);
    },
    success: function(result) {
      hide_spinner();
    },
    error: function(error) {
      hide_spinner();
    }
  });
}

function commonLoaderAjaxWithData(url, data) {
  $.ajax(url, {
    type: "get",
    data: data,
    beforeSend: function() {
      setTimeout(function(){ 
        show_spinner();
      }, 0);
    },
    success: function(result) {
      hide_spinner();
    },
    error: function(error) {
      hide_spinner();
    }
  });
}

function getShowAllList() {
  $('.get-show-all-list').click(function() {
    commonLoaderAjax($(this).data('url'));
  });
}

function getTournamentMatches() {
  $('.get-tournament-matches').click(function() {
    $('.get-tournament-matches p.selected').removeClass('selected');
    $(this).children('p').addClass('selected');
    if ($(window).width() <= 992) {
      $("#long-term-modal").fadeOut("slow");
      $("body").removeClass("overflow-hidden");
    }
    commonLoaderAjax($(this).data('url'));
  });
}

function getMatchMarkets() {
  var appendedIds = [];
  $('.get-match-markets').click(function() {
    match_id = $(this).attr('data-match-id');
    if (appendedIds.includes(match_id)) {
      $("#match-"+match_id+"-markets-list").html("");
      appendedIds = $.grep(appendedIds, function(value) {
        return value != match_id;
      });
    } else {
      $.ajax("/dashboard/get_match_markets", {
        type: "get",
        data: {
          match_id: match_id,    
        },
        beforeSend: function() {
          setTimeout(function(){ 
            show_spinner();
          }, 0);
        },
        success: function(result) {
          appendedIds.push(match_id);
          preloadActiveOutcomesFromBetslip();
          hide_spinner();
        },
        error: function(error) {
          hide_spinner();
        }
      });
    }
  });
}

function liveTabsSwitching() {
  $('.betting-tabs .nav-tabs li a').on('click', function() {
    kind = $(this).attr('data-kind');
    $(this).parent().addClass('active').siblings().removeClass('active')
    $.ajax("/live_bettings/events_list", {
      type: "get",
      data: {
        kind: kind,    
      },
      beforeSend: function() {
        setTimeout(function(){ 
          show_spinner();
        }, 0);
      },
      success: function(result) {
        hide_spinner();
        preloadActiveOutcomesFromBetslip();
      },
      error: function(error) {
        hide_spinner();
      }
    });
  });
}

function addLiveFavoriteMatches() {
  $('.add_live_favorite_matches').on('click', function() {
    curr = $(this);
    apiCallForFavoriteMatches(curr, '/live_bettings/add_favorite', 'post');
  });
}

function removeLiveFavoriteMatches() {
  $('.remove_live_favorite_matches').on('click', function() {
    curr = $(this);
    apiCallForFavoriteMatches(curr, '/live_bettings/remove_favorite', 'delete');
  });
}

function apiCallForFavoriteMatches(curr, url, type) {
  match_id = curr.attr('data-match-id');
  $.ajax(url, {
    type: type,
    data: {
      match_id: match_id,    
    },
    beforeSend: function() {
      setTimeout(function(){ 
        show_spinner();
      }, 0);
    },
    success: function(result) {
      curr.parents('.show-detail-data').remove();
      $('#matches_count').text(parseInt($('#matches_count').text()) - 1);
      if (curr.hasClass('remove_live_favorite_matches')) {
        $('#favorite_match_count').text(parseInt($('#favorite_match_count').text()) - 1);
        $('#live_match_count').text(parseInt($('#live_match_count').text()) + 1);
      } else {
        $('#favorite_match_count').text(parseInt($('#favorite_match_count').text()) + 1);
        $('#live_match_count').text(parseInt($('#live_match_count').text()) - 1);
      }
      toastr.success(result.message);
      hide_spinner();
    }
  });
}

function timeNow() {
  d = new Date()
  $('.gmt-time').html(d.toTimeString().split('(')[0])
}

// $(document).ready(function() {
//   $( ".mob-menu-btn button" ).click(function() {
//     $( "nav" ).slideToggle( "slow", function() {
//     });
//   });
//   setInterval(timeNow, 1000);
// });

//<!-- header fixed and show menu -->
$(window).scroll(function(){
  if ($(window).scrollTop() >= 100) {
    $('.top-strip').addClass('fixed-header');
    $('.new-navigation').addClass('top-navigation');
    $('#sidebar').addClass('height-adjust');

  }
  else {
    $('.top-strip').removeClass('fixed-header');
    $('.new-navigation').removeClass('top-navigation');    
    $('#sidebar').removeClass('height-adjust');
  }
});

// $(function() {
//   var offset = $("#sidebar").offset();
//   var topPadding = 10;
//   var div_height = $(".center-section").height();
//   $(window).scroll(function() {
//     if ($(window).scrollTop() > offset) {
//       $("#sidebar").stop().animate({
//         marginTop: $(window).scrollTop() - offset
//       });
//     } else {
//       $("#sidebar").stop().animate({
//         marginTop: 0
//       });
//     };
//   });
// });

// $(function() {
//   $(window).scroll(function() {
//     var sidebarHeight = $("#sidebar").height();
//     var heightcenter = $(".center-section").height();
//     if (sidebarHeight > heightcenter) {
//       alert('saurabh');
//       $("#sidebar").stop().animate({
//         marginTop: 0 
//       });
//     };
//   });
// });

function searchMatches() {
  $('.search_matches').change(function(event) {
    query = this.value.split(' vs ')[0];
    if (query.length > 3) {
      commonLoaderAjaxWithData(`/dashboard/search`, {'query': query});
    } else {
      alert('Please search for more than 3 characters.')
    }
  });
}

function openNav() {
  document.getElementById("mySidenav").style.transform = "translateX(0px)";
}

function closeNav() {
  document.getElementById("mySidenav").style.transform = "translateX(-700px)";
}