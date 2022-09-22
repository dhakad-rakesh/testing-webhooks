function sortableJs() {
  $("#sortable-body").sortable({
    update: function (event, ui) {
      var sortedIds = $("#sortable-body").sortable("toArray").filter(v => v != "");
      $.ajax({
        url: '/admin/casino_menus/change_menus_order',
        type: 'PATCH',
        data: {sorted_ids: sortedIds},
        success: function (data) {
          sortedIds.forEach(function(id, index) {
            $("#rank_"+id+"").html(index+1);
          });
          alert(data.message);
        }
      });
    }
  });
}

function updateMenuForCasinoItem(_this) {
  menu_id = _this.value;
  item_id = _this.id.replace('casino_menu_', '');

  $.ajax({
    url: '/admin/casino/update_menu_for_casino_item',
    type: 'PATCH',
    data: {menu_id: menu_id, item_id: item_id},
    success: function (data) {
      alert(data.message);
    },
    error: function (xhr, ajaxOptions, thrownError){
      alert($.parseJSON(xhr.responseText).error);
    }
  });
}

$(function() {

  // $('.i-checks').iCheck({
  //   checkboxClass: 'icheckbox_square-green',
  //   radioClass: 'iradio_square-green',
  // });

  $('.enabled_casino_item').on('change', function(event){
    let elem = $(this)
    let item_id = elem.attr("data").split("_")[2];
    let url = '/admin/casino/update_casino_item';
    let active =  elem.is(":checked");

    $.ajax({
      url: url,
      type: 'PATCH',
      data: { active: active, item_id: item_id },
      success: function (data) {
        alert(data.message);
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
  });
});


function searchCasinoItem(event) {
  var query = $('#query').val();
  var url = document.location.href;
  if (url.includes('?')) {
    document.location = `${url}&query=${query}`;
  }
  else {
    document.location = `${url}?query=${query}`;
  }
}
