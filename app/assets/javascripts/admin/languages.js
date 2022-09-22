$(function() {

  $('.i-checks').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
  });

  $('.enabled_language').on('ifChanged', function(event){
    elem = $(this)
    id = elem.attr("data").split("_")[1];
    url = "/admin/languages/" + id
    enabled =  elem.is(":checked")
      $.ajax({
        url: url,
        type: 'PATCH',
        data: {'enabled' : enabled, id: id},
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