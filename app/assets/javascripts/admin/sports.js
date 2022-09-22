// $(function() {

//   // $('.i-checks').iCheck({
//   //   checkboxClass: 'icheckbox_square-green',
//   //   radioClass: 'iradio_square-green',
//   // });

//   $('.enabled_sport').on('click', function(event) {
//     elem = $(this)
//     id = elem.attr("data").split("_")[1];
//     url = "/admin/sports/" + id
//     enabled =  elem.is(":checked")
//       $.ajax({
//         url: url,
//         type: 'PATCH',
//         data: { 'enabled' : enabled, id: id },
//         success: function (data) {
//           alert(data.message);
//         },
//         error: function (xhr, ajaxOptions, thrownError){
//           if (elem.parent().hasClass("checked"))
//             elem.prop('checked', false)
//           else
//             elem.prop('checked', true)

//           elem.iCheck('update');
//           alert($.parseJSON(xhr.responseText).error);
//         }
//       });
//   });
// });

// $('.btn-reset').click(()=>{
//   $('#name').val('');
//   $('#kind').val('');
//   $('#enabled').val('');
//   $('.btn-search').click();
// });


$('.update_sport_rank').on('click', function(event) {
  let elem = $(this)
  let id = elem.data('sport');
  let url = `/admin/sports/${id}`;
  let rank = elem.closest('tr').find('.rank').val();
  $.ajax({
    url: url,
    type: 'PATCH',
    data: { rank: rank },
    success: function (data) {
      toastr.success(data.message);
    },
    error: function (xhr, ajaxOptions, thrownError){
      toastr.error($.parseJSON(xhr.responseText).error);
    }
  });
});

function sortableJs() {
  $("#sports_list").sortable({
    update: function (event, ui) {
      updateSportsRankAjax();
    }
  });
}

function updateSportsRankAjax() {
  var sortedIds = $("#sports_list").sortable("toArray").filter(v => v != "");
  $.ajax({
    // url: '/admin/tournaments/update_tournaments_rank',
    url: '/admin/sports/update_sports_rank',
    type: 'PATCH',
    data: { sorted_ids: sortedIds },
    success: function (data) {
      sortedIds.forEach(function(id, index) {
        $("#rank_"+id+"").html(index+1);
      });
      toastr.success(data.message);
    }
  });
}

$('.btn-reset').click(()=>{
  $('#name').val('');
  $('#kind').val('');
  $('#enabled').val('');
  const data = {
    name: "",
    kind: "",
    enabled: ""
  }
  sportSearchAjax("", data, "reset");
});

$('.btn-search').on('click', function() {
  const el = $('.sport-filter-div');
  const name = el.find('#name').val();
  const kind = el.find('#kind').val();
  const enabled = el.find('#enabled').val();
  const data = {
    name: name,
    kind: kind,
    enabled: enabled
  };
  sportSearchAjax("", data, "search");
});

function sportSearchAjax(address, data, action) {
  $.ajax({
    url: '/admin/sports/search',
    type: 'GET',
    data: data,
    success: function () {
      if(action == 'search') {
        $("#sports_list").sortable('destroy');
      } else {
        sortableJs();
      }
    }
  });
}

sortableJs();
