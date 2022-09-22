function makeEnabledDisabledTournament() {
  $('.enabled_tournament').on('click', function(event) {
    elem = $(this);
    var result = confirm("Are you sure?");
    if (result) {
      id = elem.attr("data").split("_")[1];
      let url = "/admin/tournaments/" + id + "/change_status";
      enabled =  elem.is(":checked");
      $.ajax({
        url: url,
        type: 'PATCH',
        data: {'enabled': enabled, 'id': id},
        success: function (data) {
          toastr.success(data.message);
        },
        error: function (xhr, ajaxOptions, thrownError){
          if (elem.parent().hasClass("checked"))
            elem.prop('checked', false)
          else
            elem.prop('checked', true)

          elem.iCheck('update');
          alert($.parseJSON(xhr.responseText).error);
        }
      });
    } else {
      if (elem.prop('checked') == true) {
        elem.prop("checked", false)
      } else {
        elem.prop("checked", true)
      }
    }
  });
};

$('.btn-reset').click(() => {
  $('#sport_id').val('');
  $('#name').val('');
  $('#country_id').val('');
  $('#enabled').val('');
  $('.btn-search').trigger('click');
});
// function sortableJs() {
//   $("#sortable-body").sortable({
//     update: function (event, ui) {
//       updateTournamentsRankAjax();
//     }
//   });
// }

// function updateTournamentsRankAjax() {
//   var sortedIds = $("#sortable-body").sortable("toArray").filter(v => v != "");
//   $.ajax({
//     url: '/admin/tournaments/update_tournaments_rank',
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