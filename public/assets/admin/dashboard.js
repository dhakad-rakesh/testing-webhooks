function getDashboardData(t={}){updateProfit("/admin/dashboard/profit_filter",t),getAjaxLoad("/admin/dashboard/summaries_filter",t,"#summaries_filter"),getAjaxLoad("/admin/dashboard/sports_overview_filter",t,"#bet_overview_filter"),getAjaxLoad("/admin/dashboard/esports_overview_filter",t,"#combo_bet_overview_filter"),getAjaxLoad("/admin/dashboard/casino_overview_filter",t,"#casino_overview_filter"),getAjaxLoad("/admin/dashboard/slot_game_overview_filter",t,"#slot_game_overview_filter"),getAjaxLoad("/admin/dashboard/top_sports_filter",t),getAjaxLoad("/admin/dashboard/top_casino_filter",t),getAjaxLoad("/admin/dashboard/top_slot_game_filter",t)}function getDashboardDataFiltered(t,a){window.clearInterval(timer),resetProfitData(),getDashboardData(t,a)}function resetProfitData(){$("#bet-sport .data").attr("data-current",0),$("#win-sport .data").attr("data-current",0),$("#bet-esport .data").attr("data-current",0),$("#win-esport .data").attr("data-current",0),$("#bet-casino .data").attr("data-current",0),$("#win-casino .data").attr("data-current",0),$("#bet-slot .data").attr("data-current",0),$("#win-slot .data").attr("data-current",0)}function updateProfitComponent(t,a){const e=parseFloat(t.attr("data-current"));t.parent().find(".sign i");t.attr("data-current",a),t.html(`${a}\u20a9`),isNaN(e),e!=a&&isNaN(e)}function updateProfitView(t){const a=$("#bet-sport .data"),e=$("#win-sport .data"),r=$("#bet-esport .data"),o=$("#win-esport .data"),i=$("#bet-casino .data"),n=$("#win-casino .data"),p=$("#bet-slot .data"),q=$("#win-slot .data");updateProfitComponent(a,t.sports.bet),updateProfitComponent(e,t.sports.win),updateProfitComponent(r,t.esports.bet),updateProfitComponent(o,t.esports.win),updateProfitComponent(i,t.casino.bet),updateProfitComponent(n,t.casino.win),updateProfitComponent(p,t.slot.bet),updateProfitComponent(q,t.slot.win)}function updateProfit(t,a={}){return $.ajax({url:t,type:"GET",data:a,dataType:"json",success(t){updateProfitView(t)}})}var timer;$(document).ready(function(){getDashboardData()});
