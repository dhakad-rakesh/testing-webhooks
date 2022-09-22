$(function() {
  // $('.enabled_market').on('click', function(event){
  //   elem = $(this);
  //   var result = confirm("Are you sure?");
  //   if (result) {
  //     id = elem.attr("data").split("_")[1];
  //     match_id = elem.attr("data-match-id");
  //     url = "/admin/markets/update_sport_market"
  //     visible =  elem.is(":checked")
  //     $.ajax({
  //       url: url,
  //       type: 'PATCH',
  //       data: {id: id, match_id: match_id, 'sport_market': {'visible': visible}},
  //       success: function (data) {
  //         toastr.success(data.message);
  //       },
  //       error: function (xhr, ajaxOptions, thrownError){
  //         if (elem.parent().hasClass("checked"))
  //           elem.prop('checked', false)
  //         else
  //           elem.prop('checked', true)

  //         elem.iCheck('update');
  //         alert($.parseJSON(xhr.responseText).error);
  //       }
  //     });
  //   } else {
  //     if ($(this).prop('checked') == true) {
  //       $(this).prop("checked", false)
  //     } else {
  //       $(this).prop("checked", true)
  //     }
  //   }
  // });

  // $('.priority-select').on('change', function() {
  //   const path = "/admin/markets/update_sport_market";
  //   const element = this;
  //   const initialPriority = this.dataset.initialValue;
  //   const sportMarketId = this.dataset.sportMarketId;
  //   const priority = this.value;
  //   const data = {
  //     id: sportMarketId,
  //     sport_market: {
  //       priority: priority
  //     }
  //   }

  //   $.ajax({
  //     type: 'PATCH',
  //     url: path,
  //     data,
  //     success(data) {
  //       element.dataset.initialValue = priority;
  //       toastr.success(data.message);
  //     },
  //     error() {
  //       element.value = initialPriority;
  //       toastr.error("Can't change priority!");
  //     }
  //   });
  // });

  $("#sport-kind-dropdown").on("change", function() {
    sport_kind = this.value;
    $.ajax({
      url: "/admin/markets/get_sports",
      type: "GET",
      data: {'sport_kind': sport_kind},
      dataType: 'json',
      error: function (xhr, ajaxOptions, thrownError){
        toastr.error('Invalid request')
      },
      success: function(data) {
        $("#markets-sport-dropdown option").remove()
        
        data['sports'].forEach((sport) => {
          option = `<option value="${sport.id}">${sport.name}</option>`
          $(option).appendTo("#markets-sport-dropdown")
        })
      }
    });
    element = $("#markets-sport-dropdown option")[0];
    renderMarketsList(element);
  });

  $("#markets-sport-dropdown").on("change", function() {
    renderMarketsList(this);
  });

  // $('.markets_move_to_top').on('click', function() {
  //   var result = confirm("Are you sure you want to move this market at the top?");
  //   if (result) {
  //     $(this).parent().parent().prependTo("#markets-sortable-body");
  //     updateMarketsRankAjax();
  //   }
  // });

  $('.btn-reset').click(() => {
    $('#name').val('');
    $('#priority').val('');
    $('#visible').val('');
    $('.btn-search').trigger('click');
  });

});

// function sortableMarketsJs() {
//   $("#markets-sortable-body").sortable({
//     update: function (event, ui) {
//       updateMarketsRankAjax();
//     }
//   });
// }

// function updateMarketsRankAjax() {
//   var sortedIds = $("#markets-sortable-body").sortable("toArray").filter(v => v != "");
//   $.ajax({
//     url: '/admin/markets/update_markets_rank',
//     type: 'PATCH',
//     data: {sorted_ids: sortedIds},
//     success: function (data) {
//       sortedIds.forEach(function(id, index) {
//         $("#rank_"+id+"").html(index+1);
//       });
//       alert(data.message);
//     }
//   });
// }

function renderMarketsList(element) {
  sport_id = element.value;

  $.ajax({
    url: "/admin/markets/get_sports_markets",
    type: "GET",
    data: {'sport_id': sport_id},
  });
}
