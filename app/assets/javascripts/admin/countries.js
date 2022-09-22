$(function() {
  $('.enabled_country').on('click', function(event){
    elem = $(this);
    var result = confirm("Are you sure?");
    if (result) {
      id = elem.attr("data").split("_")[1];
      url = "/admin/countries/" + id + "/change_status"
      enabled =  elem.is(":checked")
      $.ajax({
        url: url,
        type: 'PATCH',
        data: {'enabled' : enabled, id: id},
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
      if ($(this).prop('checked') == true) {
        $(this).prop("checked", false)
      } else {
        $(this).prop("checked", true)
      }
    }
  });

  $('.countries_move_to_top').on('click', function() {
     $(this).parent().parent().prependTo("#countries-sortable-body");
     updateCountriesRankAjax();
  });
});

function sortableCountryJs() {
  $("#countries-sortable-body").sortable({
    update: function (event, ui) {
      updateCountriesRankAjax();
    }
  });
}

function updateCountriesRankAjax() {
  var sortedIds = $("#countries-sortable-body").sortable("toArray").filter(v => v != "");
  $.ajax({
    url: '/admin/countries/update_countries_rank',
    type: 'PATCH',
    data: {sorted_ids: sortedIds},
    success: function (data) {
      sortedIds.forEach(function(id, index) {
        if (index == 0) {
          $(`#${id} td:last`).html('');
        }
        if (index == 1) {
          $(`#${id} td:last`).html('<a class="countries_move_to_top" href="#"><span class="translation_missing" title="Move To Top">Move To Top</span></a>');
        }

        $("#rank_"+id+"").html(index+1);
      });
      setTimeout(function() {
        toastr.success(data.message);
      }, 300);
    }
  });
}
