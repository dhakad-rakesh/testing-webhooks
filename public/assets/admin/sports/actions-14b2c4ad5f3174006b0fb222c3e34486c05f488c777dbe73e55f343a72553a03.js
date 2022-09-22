$(function() {

  // $('.i-checks').iCheck({
  //   checkboxClass: 'icheckbox_square-green',
  //   radioClass: 'iradio_square-green',
  // });

  $('.enabled_sport').on('click', function(event) {
    let elem = $(this)
    let id = elem.attr("data").split("_")[1];
    let url = "/admin/sports/" + id
    let enabled =  elem.is(":checked")
      $.ajax({
        url: url,
        type: 'PATCH',
        data: { 'enabled' : enabled, id: id },
        success: function (data) {
          toastr.success(data.message);
        },
        error: function (xhr, ajaxOptions, thrownError){
          if (elem.parent().hasClass("checked"))
            elem.prop('checked', false)
          else
            elem.prop('checked', true)

          elem.iCheck('update');
          toastr.error($.parseJSON(xhr.responseText).error);
        }
      });
  });
});
