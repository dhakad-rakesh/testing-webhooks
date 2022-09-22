//= require jquery.min
//= require jquery_ujs
//= require bootstrap-sprockets
//= require ./user/owl.carousel
//= require ./user/jquery.flagstrap
//= require ./user/custom
//= require moment
//= require fm.scrollator.jquery
//= require toastr
//= require ./user/jquery.validate.min
//= require ./admin/daterangepicker.min
//= require user_application
//= require firebase_init

var firstGroupMarketUIds = ['1', '3', '4', '5', '1777', '10115'];
var secondGroupMarketUIds = ['4', '41'];
var thirdGroupMarketUIds = ['41', '42', '43'];
$(document).on("click", '.outcomes', function() {
  var active_tab = $('.bet-slip-tabs li.active a').text();
  var slip_selecting_limit = parseFloat($('[name="slip-selecting-limit"]').val());

  outcomeId = $(this).attr('data-outcome-id');
  identifier = $(this).attr('data-identifier');
  marketId = $(this).attr('data-market-id');
  matchId = $(this).attr('data-match-id');
  marketUid = $(this).attr('data-market-uid');
  odds = $(this).attr('data-odds');
  outcomeName = $(this).attr('data-name');
  matchName = $(this).attr('data-match-name');

  if ($('.bet-data').length > slip_selecting_limit) {
    alert("You can't select more than " + slip_selecting_limit + " bets at a time.");
    return;
  }

  var bettedOutcomes =  $(`.bet-data`).map(function() {
      return { outcomeId: $(this).children('.outcome-id').val(), identifier: $(this).children('.identifier').val(), marketUid: $(this).children('.market-uid'), marketId: $(this).children('.market-id').val(), matchId: $(this).children('.match-id').val()};
    }).get();
  bettedOutcomes.pop();
  var isAlreadyAdded  = bettedOutcomes.some(function (el) {
    return el.outcomeId === outcomeId && el.identifier === identifier && el.marketUid.val() === marketUid && el.marketId === marketId && el.matchId === matchId;
  });

  if (isAlreadyAdded) {
    $(`#combo .bet-data[data-name="${outcomeName}-${matchName}-${marketId}-${odds}"]`).remove();

    var total_bet_slips = ($('.bet-data').length-1);
    if (total_bet_slips < 1) {
      makeDisable($('.submit-button'));
      makeDisable($('.remove-bet-slip'));
      $('#combo_bet_stake').hide();
      $('#combo_bet_info').hide();
    } else {
      update_odds();
    }

    update_bets_count(total_bet_slips);
    update_total_combo_bid_value();

    parent_element = $(this).parent().parent();

    // remove disabled class
    if (parent_element.is('li')) {
      parent_element.parent().find('li.outcome-row').removeClass('mark-disabled');
    } else {
      parent_element.parent().find('span.outcome-row').removeClass('mark-disabled');
    }
    setContradictoryMarkets($(this).data('market-uid'), $(this).data('name'), matchId, false);

    // Remove beted class and active class
    $(this).removeClass('betted');
    parent_element.removeClass('active-number');

    // remove slip from cache
    slipData = {
      outcome_id: outcomeId,
      market_id: marketId,
      match_id: matchId
    }

    getAjax('/bets/remove_bet_slip', { bet_slip: slipData });
  } else {

    var bettedOutcomes =  $(`.bet-data`).map(function() {
      return { outcomeId: $(this).children('.outcome-id').val(), identifier: $(this).children('.identifier').val(), marketUid: $(this).children('.market-uid'), marketId: $(this).children('.market-id').val(), matchId: $(this).children('.match-id').val()};
    }).get();

    bettedOutcomes.pop();

    var isAlreadyAddedForAMatch  = bettedOutcomes.some(function (el) {
      return el.matchId === matchId;
    });

    if ( isAlreadyAddedForAMatch == true ) {
      alert("Please select another match.");
      return false
    }

    $(this).addClass('betted');
    marketName = $(this).attr('data-market-name');
    matchId = $(this).attr('data-match-id');
    marketId = $(this).attr('data-market-id');
    marketUid = $(this).attr('data-market-uid');
    identifier = $(this).attr('data-identifier');

    $('.bet-slip-entry .bet-data').attr('data-name', `${outcomeName}-${matchName}-${marketId}-${odds}`);
    $('.bet-slip-entry .outcome-name').text(`${outcomeName}`);
    $('.bet-slip-entry .odds').text(`${odds}`);
    $('.bet-slip-entry .market-name').text(`${marketName}`);
    $('.bet-slip-entry .match-name').text(`${matchName}`);
    $('.bet-slip-entry .market-id').val(`${marketId}`);
    $('.bet-slip-entry .market-uid').val(`${marketUid}`);
    $('.bet-slip-entry .match-id').val(`${matchId}`);
    $('.bet-slip-entry .identifier').val(`${identifier}`);
    $('.bet-slip-entry .outcome-id').val(`${outcomeId}`);

    var betSlipEntry = $('.bet-slip-entry').html();
    $('#combo .betting-slip').append(betSlipEntry);
    if ($('#combo .bet-data').length >= 1 ) {
      $('#combo_bet_stake').show();
      $('#combo_bet_info').show();
    }

    var total_bet_slips = ($('.bet-data').length-1);
    if (total_bet_slips > 0) {
      makeEnable($('.submit-button'));
      makeEnable($('.remove-bet-slip'));
      update_odds();
    }

    // makeEnable($('#single .bid-value'));
    // $('#single .bid-value').css('cursor', 'pointer');

    // makeDisable($('#combo .bid-value'));
    // $('#combo .bid-value').css('cursor', 'not-allowed');

    // if (total_bet_slips > 1){
    //   $('.combo-bet-stake').css("display","table");
    //   $('.combo-bet-info').css("display","table");
    //   $('#combo .bid-value').val('');
    // }

    // Active Betlisp
    $('a[href$="betslip"]').click();
    update_bets_count(total_bet_slips);
    update_total_combo_bid_value();

    parent_element = $(this).parent().parent();
    // Select and highlight outcome
    parent_element.addClass('active-number');

    // mark disbaled to same rows outcome
    disabledMainOutcomeElement(parent_element);
    setContradictoryMarkets($(this).data('market-uid') ,$(this).data('name'), matchId);

    //setting the odds 1 in temp betslip
    $('.bet-slip-entry .odds').text('1');
    $('.bet-slip-entry .match-id').text('');

    // store slip to cache
    slipData = {
      market_uid: marketUid,
      market_id: marketId,
      match_id: matchId,
      odds: odds,
      outcome_id: outcomeId,
      identifier: identifier,
      market_name: marketName,
      match_name: matchName,
      outcome_name: outcomeName
    }
    getAjax('/bets/add_bet_slip', { bet_slip: slipData });
  }
  // Enable/disable odds/lock odds
  enableDisableOdds(matchId);
});

$(document).on("input", '.bid-value', function() {
  var odd = $(this).parents('.bet-data').find('.odds').text();
  var bid = $(this).val();
  var totalValue = +odd * +bid;
  user_wallet_limit = parseFloat($('[name="max-bet-limit"]').val());
  if (totalValue >= user_wallet_limit) {
    totalValue = user_wallet_limit
  }
  $(this).parents('.match-price').find('.total-value').text(totalValue.toFixed(2));

  slipData = {
    market_id: $(this).parents('.bet-data').find('.market-id').val(),
    match_id: $(this).parents('.bet-data').find('.match-id').val(),
    outcome_id: $(this).parents('.bet-data').find('.outcome-id').val(),
    stake: bid,
    total_value: totalValue
  }

  getAjax('/bets/add_bet_slip', { bet_slip: slipData });
});

$(document).on("input", '.total-combo-bid-value', function() {
  update_total_combo_bid_value();
});

$(document).on("click", '.quick-bet ul li', function() {
  $('.total-combo-bid-value').val($(this).children().text());
  update_total_combo_bid_value();
});

$bet_slip_toggle = true;

$(document).on("click", '.submit-button', function(evt) {
  // To prevent multiples hits
  if ( $bet_slip_toggle === false ) {
    return false;
  }
  else {
    $bet_slip_toggle = false;
  }

  active_tab = $(this).parent().parent().parent().parent().attr('id');
  params = [];
  bet_type = '';
  combo_bet_stake = '';

  $(`.${active_tab}-bet-data`).each(function(i){
    market_id = $(this).find('.market-id').val();
    market_uid = $(this).find('.market-uid').val();
    match_id = $(this).find('.match-id').val();
    odds = $(this).find('.odds').text();
    outcome_id = $(this).find('.outcome-id').val();
    outcome_name = $.trim($(this).find('.outcome-name').text());
    stake = $('.total-combo-bid-value').val();
    identifier = $(this).find('.identifier').val();
    input_hash = { market_id: market_id, market_uid: market_uid, match_id: match_id, odds: $.trim(odds), outcome_id: outcome_id, stake: stake, identifier: identifier, outcome_name: outcome_name }
    params.push(input_hash);
  });

  if (params.length > 1) params.pop();
  if (params.length == 0) return;

  if (params.length > 0) {
    if (params.length == 1) {
      bet_type="single"
    } else {
      bet_type="combo"
      combo_bet_stake = $('.total-combo-bid-value').val();
      if(!isFloat(combo_bet_stake) || combo_bet_stake <= '0'){
        toastr.error("Enter a valid number");
        return;
      }
    }
  }

  var total_betted_winning = parseFloat($(this).data('total_winning'));
  var total_bet_slips_winning = 0;
  // var max_per_day_winning = parseFloat($('[name="max-bet-limit"]').val());
 
  $(`#combo .total-value`).each(function() {
    total_bet_slips_winning += (parseFloat($(this).text()) || 0);
  });

  // if((total_betted_winning + total_bet_slips_winning) > max_per_day_winning) {
  //   text = '';
  //   if (total_betted_winning > 0) {
  //     text = `Remaining winning is ${(max_per_day_winning - total_betted_winning).toFixed(2)} for today.`
  //   }
  //   message = "Winning limit exceeded. Per day winning limit is "+ max_per_day_winning.toFixed(2) + "."
  //   + text;
  //   alert(message);
  //   return;
  // }

  $.ajax("/bets", {
    dataType: "script",
    type: "post",
    data: {
      bet_slips: params,
      bet_type: bet_type,
      combo_bet_stake: combo_bet_stake      
    },
    beforeSend: function() {
      setTimeout(function(){ 
        show_spinner();
      }, 0);
    },
    
    success: function(result) {
      hide_spinner();
      update_bets_count(($('.bet-data').length-1));
    },
    error: function(error) {
      hide_spinner();
      try {
        errors = JSON.parse(error.responseText).message;
      }
      catch (exc) {
        return toastr.error(error.responseText);
      }

      if ( $.isArray(errors) ) {
        $.each(errors, function (index, value) {
          toastr.error(value.errors.join(', '));
        });
      } else {
        toastr.error(errors);
      }
    },
    complete: function(res) {
      $bet_slip_toggle = true;
    }
  });
});

$(document).on("click", '.close-button', function() {
  var active_tab = $('.bet-slip-tabs li.active a').text();
  outcomeId = $(this).parent().parent().parent().children('.outcome-id').val();
  identifier = $(this).parent().parent().parent().children('.identifier').val();
  marketId = $(this).parent().parent().parent().children('.market-id').val();
  matchId = $(this).parent().parent().parent().children('.match-id').val();
  odds = $(this).parent().find('.odds').text();
  matchName = $(this).parent().parent().parent().find('.match-name').text();
  outcomeName = $(this).parent().parent().parent().find('.outcome-name').text();

  // removed bet-data from both the tabs
  // $('.bet-slip-tabs li a').each(function() {
  //   var data_name = `${$.trim(outcomeName)}-${$.trim(matchName)}-${$.trim(marketId)}-${$.trim(odds)}`;
  //   $(`#${$(this).text().toLowerCase()} .bet-data[data-name="${data_name}"]`).remove();
  // });
  var data_name = `${$.trim(outcomeName)}-${$.trim(matchName)}-${$.trim(marketId)}-${$.trim(odds)}`;

  $(`#combo .bet-data[data-name="${data_name}"]`).remove();

  try {
    // Remove beted class and outcome-active class
    removeOutcomeRow = $(`.outcomes[data-outcome-id='${outcomeId}'][data-identifier='${identifier}'][data-market-id='${marketId}'][data-match-id='${matchId}']`);
    removeOutcomeRow.removeClass('betted');
    removeOutcomeRow.parent().parent().removeClass('active-number');

    parentOfOutcomRow = removeOutcomeRow.parent().parent();
    if (parentOfOutcomRow.is('li')) {
      parentOfOutcomRow.parent().find('li.outcome-row').removeClass('mark-disabled');
    } else {
      parentOfOutcomRow.parent().find('span.outcome-row').removeClass('mark-disabled');
    }

    // Need to look this
    setContradictoryMarkets(removeOutcomeRow.data('market-uid'), removeOutcomeRow.data('name'), matchId, false);
  }

  catch(err) {
    console.log(err);
  }

  var total_bet_slips = ($('.bet-data').length-1);
  if (total_bet_slips < 1) {
    makeDisable($('.submit-button'));
    makeDisable($('.remove-bet-slip'));
  }

  var combo_bet_slips = $('#combo .bet-data').length

  if (combo_bet_slips < 1) {
    $('.combo-bet-stake').css("display","none");
    $('.combo-bet-info').css("display","none");
    $('#combo .total-combo-bid-value').val('');
    $('#combo_bet_stake').hide();
    $('#combo_bet_info').hide();
  } else {
    update_odds();
  }

  update_bets_count(total_bet_slips);
  update_total_combo_bid_value();
  
  // remove slip from cache
  slipData = {
    outcome_id: outcomeId,
    market_id: marketId,
    match_id: matchId
  }
  getAjax('/bets/remove_bet_slip', { bet_slip: slipData });

  enableDisableOdds(matchId);
});

$(document).on("click", '.remove-bet-slip', function() {
  removeBetslipContent();
  getAjax('/bets/remove_bet_slip', { bet_slip: 'All' });
  update_bets_count(($('.bet-data').length-1));
});

function makeEnable(curr) {
  return curr.attr('disabled', false);
}

function makeDisable(curr) {
  return curr.attr('disabled', true);
}

function removeBetslipContent() {
  $(".betting-slip").html("");
  $(".outcomes").removeClass('betted');
  $(".outcome-row").removeClass('active-number').removeClass('mark-disabled');
  $('.combo-bet-stake').css("display","none");
  $('.combo-bet-info').css("display","none");
  $('.total-combo-bid-value').val('');
  makeDisable($('.submit-button'));
  makeDisable($('.remove-bet-slip'));
  $('.bid-value').removeAttr('disabled');
  $('.bid-value').css('cursor', 'text');
}

function show_spinner() {
  $('#cover-spin').show(0);
}

function hide_spinner() {
  $('#cover-spin').hide();
}

function update_odds() {
  total_odds_array = $("#combo .odds").map(function() {
    return this.innerHTML;
  }).get();

  total_odds_array = total_odds_array.filter(function(v){return v!==''});
  total_odds = total_odds_array.reduce( (a,b) => a * b );
  total_odds = parseFloat(total_odds);
  total_odds = total_odds.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
  $('.combo-odds').html(total_odds);
}

function update_bets_count(bets_count) {
  $(".bet-slip-count").html(bets_count)
  $('.combo-bet-info').find('.number-of-bets').text(bets_count);
}

function update_total_combo_bid_value() {
  odd = $(".combo-odds").html();
  bid = $(".total-combo-bid-value").val();
  totalValue = (+odd * +bid).toFixed(2).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0]
  user_wallet_limit = parseFloat($('[name="max-bet-limit"]').val());
  if (totalValue >= user_wallet_limit) {
    totalValue = user_wallet_limit
  }
  $(".total-combo-bid-value").parent().parent().parent().parent().children('.combo-bet-info').find('.total-value').text(totalValue);
}

function isFloat(val) {
  var floatRegex = /^-?\d+(?:[.,]\d*?)?$/;
  if (!floatRegex.test(val))
    return false;

  val = parseFloat(val);
  if (isNaN(val))
      return false;
  return true;
}

function onlyNumeric() {
  $(".only-numeric").bind("keypress", function (e) {
    var keyCode = e.which ? e.which : e.keyCode
    if (!(keyCode >= 48 && keyCode <= 57)) {
      return false;
    }       
  });
}

function validateSignup() {
  $.validator.addMethod("emailRegex", function(value, element) {
    return this.optional(element) || /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4}\s*)?$/i.test(value);
  }, "Please enter a valid email address.");

  $.validator.addMethod("usernameRegex", function(value, element) {
    return this.optional(element) || /[A-Za-z0-9\w]{4,20}\s*$/i.test(value);
  }, "Username must only contain alphabetic and numeric characters.");

  $.validator.addMethod("mobileRegex", function(value, element) {
    return this.optional(element) || /^\d{4,15}\s*$/i.test(value);
  }, "Please enter a valid mobile number.");

  $.validator.addMethod("nameRegex", function(value, element) {
    return this.optional(element) || /^[a-zA-Z]+(([;',. -][a-zA-Z ])?[a-zA-Z]*)\s*$/i.test(value);
  }, "Please enter valid name.");

  $('#signup_form').validate({
    rules: {
      "user[email]": {
        required: true,
        emailRegex: true
      },
      "user[password]": {
        required: true,
        minlength: 8
      },
      "user[password_confirmation]" : {
        required: true,
        equalTo : "#signup_form #user_password"
      },
      "user[username]": {
        required: true,
        minlength: 4,
        usernameRegex: true
      },
      "user[first_name]": {
        required: true,
        minlength: 3,
        nameRegex: true
      },
      "user[last_name]": {
        required: true,
        minlength: 3,
        nameRegex: true
      },
      "user[country]": {
        required: true
      },
      "user[phone_number]": {
        mobileRegex: true
      },
      "user[street]": {
        required: true
      },
      "user[town_city]": {
        required: true
      },
      "user[zip_code]": {
        required: true,
      },
      "recieve_offer_confirmation": {
        minlength: 1
      },
      "age_confirmation": {
        required: true,
        minlength: 1
      }
    }
  });
}

function validateForgotPassword() {
  $.validator.addMethod("emailRegex", function(value, element) {
    return this.optional(element) || /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4}\s*)?$/i.test(value);
  }, "Please enter a valid email address.");

  $('.forgot_password_form').validate({
    rules: {
      "user[email]": {
        emailRegex: true,
        required: true
      },
      messages: {
        "user[email]": "Email can`t be blank."
      }
    }
  });
}

function validateChangePassword() {
  $('.change_password_form').validate({
    rules: {
      "user[password]": {
        required: true,
        minlength: 8
      },
      "user[password_confirmation]" : {
        required: true,
        equalTo : ".change_password_form #user_password"
      },
      messages: {
        "user[password]": "Password can`t be blank.",
        "user[password_confirmation]": "Password confirmation can`t be blank."
      }
    }
  });
}

function validateEditProfilePage() {
  $.validator.addMethod("emailRegex", function(value, element) {
    return this.optional(element) || /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4}\s*)?$/i.test(value);
  }, "Please enter a valid email address.");

  $.validator.addMethod("usernameRegex", function(value, element) {
    return this.optional(element) || /[A-Za-z0-9\w]{4,20}\s*$/i.test(value);
  }, "Username must only contain alphabetic and numeric characters.");

  $.validator.addMethod("mobileRegex", function(value, element) {
    return this.optional(element) || /^\d{4,15}\s*$/i.test(value);
  }, "Please enter a valid mobile number.");

  $.validator.addMethod("nameRegex", function(value, element) {
    return this.optional(element) || /^[a-zA-Z]+(([;',. -][a-zA-Z ])?[a-zA-Z]*)\s*$/i.test(value);
  }, "Please enter valid name.");

  $('.account_setting').validate({
    rules: {
      "user[email]": {
        required: true,
        emailRegex: true
      },
      "user[password]": {
        minlength: 8
      },
      "user[password_confirmation]" : {
        equalTo : ".account_setting #user_password"
      },
      "user[username]": {
        required: true,
        minlength: 4,
        usernameRegex: true
      },
      "user[first_name]": {
        required: true,
        minlength: 3,
        nameRegex: true
      },
      "user[last_name]": {
        required: true,
        minlength: 3,
        nameRegex: true
      },
      "user[phone_number]": {
        mobileRegex: true
      },
      "user[street]": {
        required: true
      },
      "user[town_city]": {
        required: true
      },
      "user[zip_code]": {
        required: true
      }
    }
  });
}

function setContradictoryMarkets(currentOutcomeUId, currentOutcomeName, matchId, markDisabled=true) {
  currentOutcomeUId = currentOutcomeUId.toString();
  if (currentOutcomeName === 1) currentOutcomeName = 'Home';
  if (currentOutcomeName === 2) currentOutcomeName = 'Away';
  if (currentOutcomeName === 'X') currentOutcomeName = 'Draw';
  // split currentOutcomeName to get search query
  currentOutcomeNames = currentOutcomeName.toString().split(' ');
  if (firstGroupMarketUIds.includes(currentOutcomeUId)) {
    // iterated marketUIds for disable/enable contradictory markets.
    $.each(firstGroupMarketUIds, function(index, id) {
      query = (marketId == '4') ? currentOutcomeNames[0] : currentOutcomeNames[currentOutcomeNames.length-1];
      if (['1', '3'].includes(id)) { // Full time result, Double chance
        if (query === 'Home') query = '1';
        if (query === 'Away') query = '2';
        if (query === 'Draw') query = 'X';
        outcomeRows = find1stGroupMarketOutcomes(id, matchId, query);
      } else if (id == '5') { // Half Time Full Time
        if (query === 'X') query = 'Draw';
        outcomeRows = find1stGroupMarketOutcomes(id, matchId, query);
      } else if (['4', '1777', '10115'].includes(id)) { // Correct Score, Live Fulltime result, Live Double chance
        if (query === 'Draw') query = 'X';
        outcomeRows = find1stGroupMarketOutcomes(id, matchId, query);
      } else {
        return;
      }
      // Added/Removed mark-disabled class
      addorremoveDisabledClass(outcomeRows, markDisabled)
    });
  }
  if (secondGroupMarketUIds.includes(currentOutcomeUId)) {
    // iterated marketUIds for disable/enable contradictory markets.
    $.each(secondGroupMarketUIds, function(index, id) {
      query = currentOutcomeNames[currentOutcomeNames.length-1];
      outcomeRows = find2ndGroupMarketOutcomes(id, matchId, query);
      // Added/Removed mark-disabled class
      addorremoveDisabledClass(outcomeRows, markDisabled)
    });
  }
  if (thirdGroupMarketUIds.includes(currentOutcomeUId)) {
    bettedOutcomes = $('ul.inner-detail').find('.outcomes.betted');
    bettedOutcomesNames = bettedOutcomes.map(function(i) {
      if (thirdGroupMarketUIds.includes($(this).data('market-uid').toString())) {
        names = $(this).data('name').toString().split(' ');
        return names[names.length - 1];
      }
    }).get();
    bettedMarketUIds = bettedOutcomes.map(function(i) {
      return $(this).data('market-uid');
    }).get();
    if (bettedOutcomesNames.length < 2) return;
    // iterated marketUIds for disable/enable contradictory markets.
    $.each(thirdGroupMarketUIds, function(index, id) {
      if (!(bettedMarketUIds.includes(parseInt(id)))) {
        outcomeRows = find3rdGroupMarketOutcomes(id, matchId, bettedOutcomesNames);
        // Added/Removed mark-disabled class
        addorremoveDisabledClass(outcomeRows, markDisabled)
      }
    });
  }
}

function find1stGroupMarketOutcomes(marketId, matchId, query='') {
  outcomes = $(`.outcomes[data-market-id='${marketId}'][data-match-id='${matchId}']`);
  if (query) {
    // list of filtered outcomes
    return outcomes.filter(function(i) {
      names = $(this).data('name').toString().split(' ');
      filtered_name = (marketId == '4') ? names[0] : names[names.length-1];
      if (['1X', 'Home or X'].includes(query)) {
        if (['Away', '2'].includes(filtered_name)) return $(this);
      } else if (['X2', 'Away or X'].includes(query)) {
        if (['Home', '1'].includes(filtered_name)) return $(this);
      } else if (['12', 'Home or Away'].includes(query)) {
        if (['Draw', 'X'].includes(filtered_name)) return $(this);
      } else {
        if (!(filtered_name.includes(query))) return $(this);
      }
    });
  } else {
    return outcomes;
  }
}

function find2ndGroupMarketOutcomes(marketId, matchId, query) {
  outcomes = $(`.outcomes[data-market-id='${marketId}'][data-match-id='${matchId}']`);
  // list of filtered outcomes
  return outcomes.filter(function(i) {
    names = $(this).data('name').toString().split(' ');
    filtered_name = names[names.length-1];
    if (marketId == '4') {
      // List cross odds e.g if you select odd odds then it will list all even odds.
      if (query == 'Even' && getEvenOrOddValue(filtered_name, 1)) return $(this);
      if (query == 'Odd' && getEvenOrOddValue(filtered_name)) return $(this);
    } else if (marketId == '41') {
      // List cross odds e.g if you select odd odds then it will list all even odds.
      if (filtered_name == 'Even' && getEvenOrOddValue(query, 1)) return $(this);
      if (filtered_name == 'Odd' && getEvenOrOddValue(query)) return $(this);
    } else {
      return;
    }
  });
}

function find3rdGroupMarketOutcomes(marketId, matchId, bettedOutcomesNames) {
  outcomes = $(`.outcomes[data-market-id='${marketId}'][data-match-id='${matchId}']`);
  // list of filtered outcomes
  query = 'Even'
  if (bettedOutcomesNames[0] == 'Even' && bettedOutcomesNames[1] == 'Odd') query = 'Odd';
  if (bettedOutcomesNames[0] == 'Odd' && bettedOutcomesNames[1] == 'Even') query = 'Odd';
  if (bettedOutcomesNames[0] == 'Odd' && bettedOutcomesNames[1] == 'Odd') query = 'Even';
  return outcomes.filter(function(i) {
    names = $(this).data('name').toString().split(' ');
    filtered_name = names[names.length-1];
    if (!(filtered_name.includes(query))) return $(this);
  });
}

function getEvenOrOddValue(query, no=0) {
  queries = query.split('-');
  return ((parseInt(queries[0]) + parseInt(queries[1])) % 2 == no);
}

function addorremoveDisabledClass(outcomeRows, markDisabled) {
  parentOfOutcomeRow = outcomeRows.parent().parent();
  // Added/Removed mark-disabled class
  markDisabled ? parentOfOutcomeRow.addClass('mark-disabled') : parentOfOutcomeRow.removeClass('mark-disabled');
}

function preloadActiveOutcomesFromBetslip() {
  activeTab = $('.bet-slip-tabs li.active a').text();
  $('.combo-bet-data').each(function() {
    outcomeId = $(this).find('.outcome-id').val();
    identifier = $(this).find('.identifier').val();
    marketId = $(this).find('.market-id').val();
    matchId = $(this).find('.match-id').val();
    outcome = $(`.outcomes[data-outcome-id='${outcomeId}'][data-identifier='${identifier}'][data-market-id='${marketId}'][data-match-id='${matchId}']`);
    if (outcome.length < 1) return;
    outcome.addClass('betted');
    parentOutcomeElement = outcome.parent().parent();
    parentOutcomeElement.addClass('active-number');

    // Disabled un-active elements
    // $('.outcome-row').not('.active-number').addClass('mark-disabled');
  
    // Enable/disable odds/lock odds
    enableDisableOdds(matchId);

    parentOutcomeElement.parent().removeClass('mark-disabled');
    // enable/disable contradictory markets
    setContradictoryMarkets(outcome.data('market-uid'), outcome.data('name'), matchId);
  });
}

function disabledMainOutcomeElement(parentOutcomeElement) {
  if (parentOutcomeElement.is('li')) {
    parentOutcomeElement.parent().find('li.outcome-row').not('.active-number').addClass('mark-disabled');
  } else {
    parentOutcomeElement.parent().find('span.outcome-row').not('.active-number').addClass('mark-disabled');
  }
}

function enableDisableOdds(matchId) {
  if ( $(`#match-${matchId}-markets-list .active-number`).length != 0 )  {
    $(`#match-${matchId}-markets-list .outcome-row`).not('.active-number').addClass('mark-disabled');
  } else {
    $(`#match-${matchId}-markets-list .outcome-row`).not('.active-number').removeClass('mark-disabled');
  }
}