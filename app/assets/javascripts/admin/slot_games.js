$(function() {  
  $('.enabled_slot_game').on('change', function(event){
    update_slot_game(this, 'active');
  });

  $('.featured_slot_game').on('change', function(event){
    update_slot_game(this, 'is_featured');
  });
});

function update_slot_game(element, attribute){
  let elem = $(element)
  let game_id = elem.attr("data").split("_")[2];
  let url = `/admin/slot_games/${game_id}`;
  let active =  elem.is(":checked");
  let attr = {};
  attr[attribute]= active
  $.ajax({
    url: url,
    type: 'PATCH',
    data: attr,
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
}

function searchSlotGame(event) {
  var query = $('#query').val();
  var url = document.location.href;
  if (url.includes('?')) {
    document.location = `${url}&query=${query}`;
  }
  else {
    document.location = `${url}?query=${query}`;
  }
}
