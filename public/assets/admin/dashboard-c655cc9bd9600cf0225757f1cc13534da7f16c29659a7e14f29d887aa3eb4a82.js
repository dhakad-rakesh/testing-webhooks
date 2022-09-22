// $(function () {
//   getAjax('/admin/dashboard').then(res => {
//     if(!$.isEmptyObject(res.sport.data)){
//       $('#sport-popularity').removeClass('hide');
//       plot_pie_chart(res.sport);
//       removeSpinner('sport-popularity');
//     }
//     if(!$.isEmptyObject(res.user_sign_up.data)){
//       $('#users-registered').removeClass('hide');
//       plot_line_chart(res.user_sign_up.labels, res.user_sign_up.data, $("#user_sign_up_count"));
//       removeSpinner('users-registered');
//     }
//     if(!$.isEmptyObject(res.user_login.data)){
//       $('#users-logged-in').removeClass('hide');
//       plot_line_chart(res.user_login.labels, res.user_login.data, $("#user_login_count"));
//       removeSpinner('users-logged-in');
//     }
//   });
// });

$(document).ready(function(){
  getDashboardData();
});

// function getAjax(address, data = {}, component_selector) {
//   return $.ajax({
//     url: address,
//     type: "GET",
//     data: data,
//     dataType: 'script',
//     beforeSend() {
//       if(component_selector) {
//         $(`${component_selector}`).parent('.ibox-content').toggleClass('sk-loading');
//       }
//     },
//     success() {
//       if(component_selector) {
//         $(`${component_selector}`).parent('.ibox-content').toggleClass('sk-loading');
//       }
//     }
//   });
// }

var timer;

function getDashboardData(data = {}, interval = true) {
  if(interval) {
    timer = setInterval(function(){
      updateProfit('/admin/dashboard/profit_filter', data)
    }, 5000);
  }
  updateProfit('/admin/dashboard/profit_filter', data);
  getAjaxLoad('/admin/dashboard/summaries_filter', data, '#summaries_filter');
  getAjaxLoad('/admin/dashboard/sports_overview_filter', data, '#bet_overview_filter');
  getAjaxLoad('/admin/dashboard/esports_overview_filter', data, '#combo_bet_overview_filter');
  getAjaxLoad('/admin/dashboard/top_sports_filter', data);
}

function getDashboardDataFiltered(data, interval) {
  window.clearInterval(timer);
  resetProfitData();
  getDashboardData(data, interval);
}

function resetProfitData() {
  $('#bet-sport .data').attr('data-current', 0);
  $('#win-sport .data').attr('data-current', 0);
  $('#bet-esport .data').attr('data-current', 0);
  $('#win-esport .data').attr('data-current', 0);
}

// function plot_pie_chart(data) {
//   var pie_data = [];

//   data.forEach(function(element) {
//     pie_data.push({ label: element.name, data: element.count })
//   });

//   var plotObj = $.plot($("#flot-pie-chart"), pie_data, {
//     series: {
//       pie: {
//         show: true
//       }
//     },
//     grid: {
//       hoverable: true
//     },
//     tooltip: true,
//     tooltipOpts: {
//       content: "%p.0%, %s",
//       shifts: {
//         x: 20,
//         y: 0
//       },
//       defaultTheme: false
//     }
//   });
// }

// function plot_line_chart(labels, data, elem) {
//   var lineData = {
//     labels: labels,
//     datasets: [
//       {
//         label: "user",
//         backgroundColor: 'rgba(26,179,148,0.5)',
//         borderColor: "rgba(26,179,148,0.7)",
//         pointBorderColor: "#fff",
//         fill: false,
//         data: data
//       }
//     ]
//   };
//   var lineOptions = {
//     responsive: true
//   };
//   var ctx = elem;
//   new Chart(ctx, {type: 'line', data: lineData, options:lineOptions});
// }

// function userCount(e, type, interval){
//   elem = $(e);
//   elem.siblings().addClass("btn-white");
//   elem.siblings().removeClass('btn-primary');
//   elem.addClass("btn-primary");
//   elem.removeClass("btn-white");
//   getAjax('/admin/dashboard/user_chart', { type: type, interval: interval }).then(res => {
//     plot_line_chart(res.user_sign_up.labels, res.user_sign_up.data, $("#user_" + type + "_count"));
//   });
// }

// function removeSpinner(id){
//   $('#' + id + '-content').removeClass('sk-loading','hide');
//   $('#spinner-' + id).addClass('hide');
// }

function updateProfitComponent(selector, newProfit) {
  const currentProfit = parseFloat(selector.attr('data-current'));
  const icon = selector.parent().find('.sign i');
  selector.attr('data-current', newProfit);
  selector.html(`${newProfit}ع.د`);
  if(isNaN(currentProfit)) {
    // selector.attr('data-current', newProfit);
    // selector.html(newProfit);
  }
  if(!(currentProfit == newProfit) && !isNaN(currentProfit)) {
    // selector.attr('data-current', newProfit);
    // selector.html(newProfit);

    if(newProfit > currentProfit) {
      // icon.removeClass('fa-rotate-90');
      // icon.parent().removeClass('text-danger');
      // icon.addClass('fa-rotate-270');
      // icon.parent().addClass('text-navy');
    } else {
      // icon.removeClass('fa-rotate-270');
      // icon.parent().removeClass('text-navy');
      // icon.addClass('fa-rotate-90');
      // icon.parent().addClass('text-danger');
    }
  }
}

function updateProfitView(data) {
  const betSport = $('#bet-sport .data');
  const winSport = $('#win-sport .data');
  const betEsport = $('#bet-esport .data');
  const winEsport = $('#win-esport .data');
  updateProfitComponent(betSport, data.sports.bet);
  updateProfitComponent(winSport, data.sports.win);
  updateProfitComponent(betEsport, data.esports.bet);
  updateProfitComponent(winEsport, data.esports.win);
}

function updateProfit(address, data = {}) {
  return $.ajax({
    url: address,
    type: "GET",
    data: data,
    dataType: 'json',
    success(data) {
      updateProfitView(data);
    }
  });
}
;
