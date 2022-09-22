// function disableUserSport(id, data) {
//   $.ajax({
//     url: `/admin/users/${id}/update_sport_visibility`,
//     type: 'PATCH',
//     data: data,
//     success: function (data) {
//       toastr.success(data.message);
//     },
//     error: function (xhr, ajaxOptions, thrownError){
//       if (elem.parent().hasClass("checked"))
//         elem.prop('checked', false)
//       else
//         elem.prop('checked', true)

//       elem.iCheck('update');
//       alert($.parseJSON(xhr.responseText).error);
//     }
//   });
// }
function userAjaxCall(id, data) {
  $.ajax({
    url: `/admin/users/${id}/update_sport_visibility`,
    type: 'PATCH',
    data: data,
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
}

$('.search').on('click', () => {
  const path = "/admin/users/search"
  const data = {
    reseller_user_id: $("#reseller_user_id").val(),
    registration_date: $("#registration_date").val(),
    reg_start_date: $("#reg_start_date").val(),
    reg_end_date: $("#reg_end_date").val(),
    query: $("#query").val(),
    id: $("#id").val(),
    last_sign_in_at: $("#last_sign_in_at").val(),
    last_sign_in_start_date: $("#last_sign_in_start_date").val(),
    last_sign_in_end_date: $("#last_sign_in_end_date").val(),
    currency: $("#currency").val(),
    phone: $("#phone_no").val(),
    min_amt: $("#min_amt").val(),
    max_amt: $("#max_amt").val(),
    country: $("#country").val(),
    city: $("#city").val(),
    user_email: $("#user_email").val(),
    email_status: $("#email_status").val(),
    admin_user_id: $("#admin_user_id").val()
  }

  getAjaxLoad(path, data, '#users_list')
});

$('.reset').on('click', () => {
  $("#registration_date").val('');
  $("#reg_start_date").val('');
  $("#reg_end_date").val('');
  $("#query").val('');
  $("#id").val('');
  $("#last_sign_in_at").val('');
  $("#last_sign_in_start_date").val('');
  $("#last_sign_in_end_date").val('');
  $("#currency").val('');
  $("#phone_no").val('');
  $("#min_amt").val('');
  $("#max_amt").val('');
  $("#country").val('');
  $("#city").val('');
  $('#reseller_user_id').val('');
  $("#user_email").val('')
  $("#email_status").val('')
  $('.select-2').trigger('change');
  $('.search').trigger('click');
});
