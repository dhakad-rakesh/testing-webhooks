// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//

//= require jquery.min
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu
//= require pace/pace.min
//= require peity/jquery.peity.min
//= require slimscroll/jquery.slimscroll.min
//= require ./admin/inspinia
//= require ./admin/tables
//= require ./admin/forms
//= require moment
//= require bootstrap-datetimepicker
//= require fm.scrollator.jquery
//= require toastr
//= require bxslider/jquery.bxslider.min
//= require firebase_init
//= require cable

// $(document).on("click", '.outcomes', function() {
//   var slip_selecting_limit = parseFloat($('[name="slip-selecting-limit"]').val());
  
//   if ($('#betslip .bet-data').length >= slip_selecting_limit) {
//     alert("You can't select more than " + slip_selecting_limit + " bets at a time.");
//     return;
//   }
  
//   outcomeId = $(this).attr('data-outcome-id');
//   identifier = $(this).attr('data-identifier');
//   marketId = $(this).attr('data-market-id');
//   matchId = $(this).attr('data-match-id');
//   marketUid = $(this).attr('data-market-uid');

//   var bettedOutcomes =  $(".bet-data").map(function() {
//       return { outcomeId: $(this).children('.outcome-id').val(), identifier: $(this).children('.identifier').val(), marketUid: $(this).children('.market-uid'), matchId: $(this).children('.match-id').val()};
//     }).get();
//   bettedOutcomes.pop();
//   var isAlreadyAdded  = bettedOutcomes.some(function (el) {
//     return el.outcomeId === outcomeId && el.identifier === identifier && el.marketUid.val() === marketUid && el.matchId === matchId;
//   });

//   if (!isAlreadyAdded) {
//     $(this).addClass('betted');
//     odds = $(this).attr('data-odds');
//     outcomeName = $(this).attr('data-name');
//     marketName = $(this).attr('data-market-name');
//     matchName = $(this).attr('data-match-name');
//     matchId = $(this).attr('data-match-id');
//     marketId = $(this).attr('data-market-id');
//     marketUid = $(this).attr('data-market-uid');
//     identifier = $(this).attr('data-identifier');
//     $('.bet-slip-entry .outcome-name').text(`${outcomeName}`);
//     $('.bet-slip-entry .odds').text(`${odds}`);
//     $('.bet-slip-entry .market-name').text(`${marketName}`);
//     $('.bet-slip-entry .match-name').text(`${matchName}`);
//     $('.bet-slip-entry .market-id').val(`${marketId}`);
//     $('.bet-slip-entry .market-uid').val(`${marketUid}`);
//     $('.bet-slip-entry .match-id').val(`${matchId}`);
//     $('.bet-slip-entry .identifier').val(`${identifier}`);
//     $('.bet-slip-entry .outcome-id').val(`${outcomeId}`);
//     var betSlipEntry = $('.bet-slip-entry').html();
//     $('.bet-slip').append(betSlipEntry);
//     //setting the odds 1 in temp betslip
//     $('.bet-slip-entry .odds').text('1');
//     $('.bet-slip-entry .match-id').text('');
    
//     var total_bet_slips = $('#betslip .bet-data').length
//     $(".bet-slip-count").html(total_bet_slips)
//     if (total_bet_slips > 1){
//       $('.combo-bet-data').css("display","block");
//       $('.bid-value').attr('disabled', 'disabled');
//       $('.bid-value').css('cursor', 'not-allowed');
//       $('.bid-value').val('');
//       update_odds();
//     }
//     // Select and highlight outcome
//     $(this.parentElement.parentElement).addClass('outcome-active');
//     // Active Betlisp
//     $('a[href$="betslip"]').click();
//     update_unique_match_count();
//     update_total_combo_bid_value();
    
//     // store slip to cache
//     slipData = {
//       market_uid: marketUid,
//       market_id: marketId,
//       match_id: matchId,
//       odds: odds,
//       outcome_id: outcomeId,
//       identifier: identifier,
//       market_name: marketName,
//       match_name: matchName,
//       outcome_name: outcomeName
//     }
//     getAjax('/bets/add_bet_slip', { bet_slip: slipData });
//   }
// });

// $(document).on("input", '.bid-value', function() {
//   var odd = $(this).parents('ul').find($('.odds')).text();
//   var bid = $(this).val();
//   var totalValue = +odd * +bid;
//   $(this).parents('.currency').find($('.total-value')).text(totalValue.toFixed(2));

//   slipData = {
//     market_id: $(this).parents('.bet-data').find('.market-id').val(),
//     match_id: $(this).parents('.bet-data').find('.match-id').val(),
//     outcome_id: $(this).parents('.bet-data').find('.outcome-id').val(),
//     stake: bid,
//     total_value: totalValue
//   }

//   getAjax('/bets/add_bet_slip', { bet_slip: slipData });
// });

// $(document).on("input", '.total-combo-bid-value', function() {
//   update_total_combo_bid_value();
// });

// $(document).on("click", '.submit-button', function() {
//   var params = [];
//   bet_type = ''
//   combo_bet_stake = ''
//   $(".bet-data").each(function(i){
//     market_id = $(this).find('.market-id').val();
//     market_uid = $(this).find('.market-uid').val();
//     match_id = $(this).find('.match-id').val();
//     odds = $(this).find('.odds').text();
//     outcome_id = $(this).find('.outcome-id').val();
//     stake = $(this).find('.bid-value').val();
//     identifier = $(this).find('.identifier').val();
//     params.push({ market_id: market_id, market_uid: market_uid, match_id: match_id, odds: odds, outcome_id: outcome_id, stake: stake, identifier: identifier })
//   });
//   params.pop();
//   if(params.length == 0) {
//     return;
//   }

//   if(params.length > 1) {
//     bet_type="combo"
//     combo_bet_stake = $('.total-combo-bid-value').val();
//     if(!isFloat(combo_bet_stake) || combo_bet_stake <= '0'){
//       toastr.error("Enter a valid number");
//       return;
//     }
//   }

//   var total_betted_winning = parseFloat($('.submit-button').data('total_winning'));
//   var total_bet_slips_winning = 0;
//   var max_per_day_winning = parseFloat($('[name="max-bet-limit"]').val());
 
//   $('.total-value').each(function() {
//     total_bet_slips_winning += (parseFloat($(this).text()) || 0);
//   })
//   if((total_betted_winning + total_bet_slips_winning) > max_per_day_winning) {
//     text = ''
//     if(total_betted_winning > 0) {
//       text = `You have already betted to win ${total_betted_winning} `;
//     }
    
//     message = "Winning limit exceeded. Per day winning limit is "+ max_per_day_winning + "."
//       + text
//       + `Your current bet slip winning is ${total_bet_slips_winning} `
//       + `Remaining winning is ${max_per_day_winning - total_betted_winning} for today.`
    
//     alert(message);
//     return;
//   }
  
//   $.ajax("/bets", {
//     dataType: "script",
//     type: "post",
//     data: {
//       bet_slips: params,
//       bet_type: bet_type,
//       combo_bet_stake: combo_bet_stake      
//     },
//     beforeSend: function() {
//       setTimeout(function(){ 
//         show_spinner();
//       }, 0);
//     },
    
//     success: function(result) {
//       hide_spinner();
//     },
//     error: function(error) {
//       hide_spinner();
//       try {
//         errors = JSON.parse(error.responseText).message;
//       }
//       catch (exc) {
//         return toastr.error(error.responseText);
//       }

//       if ( $.isArray(errors) ) {
//         $.each(errors, function (index, value) {
//           toastr.error(value.errors.join(', '));
//         });
//       } else {
//         toastr.error(errors);
//       }
//     }
//   });
// });

// $(document).on("click", '.close-button', function() {
//   outcomeId = $(this).parent().parent().parent().children('.outcome-id').val();
//   identifier = $(this).parent().parent().parent().children('.identifier').val();
//   marketId = $(this).parent().parent().parent().children('.market-id').val();
//   matchId = $(this).parent().parent().parent().children('.match-id').val();
//   $(this).parents('.bet-data').remove();
  
//   // Remove beted class and outcome-active class
//   $(`.outcomes[data-outcome-id='${outcomeId}'][data-identifier='${identifier}'][data-market-id='${marketId}']`).removeClass('betted');
//   $(`.outcomes[data-outcome-id='${outcomeId}'][data-identifier='${identifier}'][data-market-id='${marketId}']`).parent().parent().removeClass('outcome-active');
  
//   var total_bet_slips = $('#betslip .bet-data').length
//   if (total_bet_slips < 2){
//     $('.combo-bet-data').css("display","none");
//     $('.bid-value').removeAttr('disabled');
//     $('.bid-value').css('cursor', 'text');
//   } else {
//     update_odds();
//   }
//   $(".bet-slip-count").html(total_bet_slips)
//   update_unique_match_count();
//   update_total_combo_bid_value();
  
//   // remove slip from cache
//   slipData = {
//     outcome_id: outcomeId,
//     market_id: marketId,
//     match_id: matchId
//   }
//   getAjax('/bets/remove_bet_slip', { bet_slip: slipData });
// });

// $(document).on("click", '.remove-bet-slip', function() {
//   $(".bet-slip").html("")
//   $(".outcomes").removeClass('betted')
//   $(".nav-item").removeClass('outcome-active')
//   $('.combo-bet-data').css("display","none");
//   $('.bid-value').removeAttr('disabled');
//   $('.bid-value').css('cursor', 'text');
//   getAjax('/bets/remove_bet_slip', { bet_slip: 'All' });
// });

$(window).on('load',function(){
  $('#rcModal').modal('show');
});

$(function () {
  $('#datetimepicker4').datetimepicker({
    useCurrent: false
  });

  var dateNow = new Date();

  $('#datetimepicker3').datetimepicker({
    format: 'HH:mm',
    useCurrent: false,
    defaultDate:moment(dateNow).hours(0).minutes(0).seconds(0).milliseconds(0)
  });
});

// $(function () {
//   var $scrollable_div1 = $('#middle-content, #left-bar, #right-bar');
//   if ($scrollable_div1.data('scrollator') === undefined) {
//     $scrollable_div1.scrollator();
//   }
// });

// $(function(){
//   $('#middle-content').css({ height: $(window).innerHeight() - 142 });
//   $(window).resize(function(){
//     $('#middle-content').css({ height: $(window).innerHeight() - 142 });
//   });
// });


// $(function(){
//   $('#left-bar').css({ height: $(window).innerHeight() - 168 });
//   $(window).resize(function(){
//     $('#left-bar').css({ height: $(window).innerHeight() - 168 });
//   });
// });

// $(function(){
//   $('#betslip, #mybet').css({ height: $(window).innerHeight() - 275 });
//   $(window).resize(function(){
//     $('#betslip, #mybet').css({ height: $(window).innerHeight() - 275 });
//   });
// });

// $(function(){
//   $('.parent-section').css({ height: $(window).innerHeight() - 120 });
//   $(window).resize(function(){
//     $('.parent-section').css({ height: $(window).innerHeight() - 120 });
//   });
// });


function CommingSoonAlert() {
  toastr.success('Comming Soon!!');
}

$(document).ready(function(){
  $('.slider').bxSlider({
    // minSlides: 1,
    // maxSlides: 3,
    // slideWidth: 1920,
    slideheight: 300,
    // slideMargin: 10,
    responsive: true,
    infiniteLoop: true,
    adaptiveHeight: true
  });
});

function getAjax(address, data = {}) {
  return $.ajax({
    url: address,
    type: "GET",
    data: data,
    dataType: 'json',
  });
}

// function show_spinner() {
//   $('#cover-spin').show(0);
// }

// function hide_spinner() {
//   $('#cover-spin').hide();
// }

// function update_odds() {
//   total_odds_array = $(".odds").map(function() {
//     return this.innerHTML;
//   }).get()
//   total_odds_array = total_odds_array.filter(function(v){return v!==''});
//   total_odds = total_odds_array.reduce( (a,b) => a * b )
//   total_odds = total_odds.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0]
//   $('.combo-odds').html(total_odds)
// }

// function onlyUnique(value, index, self) { 
//   return self.indexOf(value) === index;
// }

// function update_unique_match_count() {
//   match_ids = $(".bet-slip .match-id").map(function() {
//                 return this.value;
//               }).get()
//   match_ids = match_ids.filter(onlyUnique);
//   match_ids = match_ids.filter(function(v){return v!==''});
//   $('#total-betted-matches').html(match_ids.length);
// }

// function update_total_combo_bid_value() {
//   odd = $(".combo-odds").html();
//   bid = $(".total-combo-bid-value").val();
//   totalValue = (+odd * +bid).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0]
//   $(".total-combo-bid-value").parents('.combo-bet-data').find('.total-value').text(totalValue);
// }

// function isFloat(val) {
//   var floatRegex = /^-?\d+(?:[.,]\d*?)?$/;
//   if (!floatRegex.test(val))
//     return false;

//   val = parseFloat(val);
//   if (isNaN(val))
//       return false;
//   return true;
// }

// cashout 
function cashout(data) {
  if (data.combo_id != undefined) {
    if (data.mismatch != undefined) {
      var message = `Are you sure, you still want to cashout the combo bets?\n New Cashoutable Odds: ${data.cashoutable.odds} \n New Cashoutable Amount: ${data.cashoutable.amount.toFixed(2)}`
    } else {
      var message = `Are you sure, you want to cashout the combo bets?\n Cashoutable Odds: ${data.cashoutable.odds} \n Cashoutable Amount: ${data.cashoutable.amount.toFixed(2)}`
    }
  } else {
    if (data.mismatch != undefined) {
      var message = `Are you sure, you still want to cashout the bet?
      \n New Cashoutable Odds: ${data.cashoutable.odds} \n New Cashoutable Amount: ${data.cashoutable.amount.toFixed(2)}`
    } else {
      var message = `Are you sure, you want to cashout the bet?
      \n Cashoutable Odds: ${data.cashoutable.odds} \n Cashoutable Amount: ${data.cashoutable.amount.toFixed(2)}`
    }
  }
  if (confirm(message)) {
    var url = "/cashout";
    $.ajax(url, {
      type: "post",
      data: data,
      beforeSend: function() {
        console.log("loading....")
      },
      success: function(result) {
        console.log('Done');
      },
      error: function(error) {
        console.log(error);
      }
    });
  }
}