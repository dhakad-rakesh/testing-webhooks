function getAjax(address, data = {}) {
  return $.ajax({
    url: address,
    type: "GET",
    data: data,
    dataType: 'json',
  });
}

function deleteAjax(address, data = {}, action_selector) {
  return $.ajax({
    url: address,
    type: "DELETE",
    data,
    dataType: 'json',
    success(data) {
      $(action_selector).parent().html("<span style='color: red'>Suspended</span>")
      toastr.success(data.message);
    },
    error(data) {
      toastr.error(data.message);
    }
  });
}

function getAjaxJs(address, data = {}){
  return $.ajax({
    type: 'GET',
    url: address,
    dataType: 'script',
    data: data
  });
}

function postAjaxJs(address, data = {}){
  return $.ajax({
    type: 'POST',
    url: address,
    dataType: 'script',
    data: data
  });
}

function patchAjaxJs(address, data = {}){
  return $.ajax({
    type: 'PATCH',
    url: address,
    dataType: 'script',
    data: data
  });
}

function getAjaxLoad(address, data = {}, component_selector) {
  return $.ajax({
    url: address,
    type: "GET",
    data: data,
    dataType: 'script',
    beforeSend() {
      if(component_selector) {
        $(`${component_selector}`).parent('.ibox-content').toggleClass('sk-loading');
      }
    },
    success() {
      if(component_selector) {
        $(`${component_selector}`).parent('.ibox-content').toggleClass('sk-loading');
      }
    },
    error() {
      if(component_selector) {
        $(`${component_selector}`).parent('.ibox-content').toggleClass('sk-loading');
        toastr.error("Something went wrong")
      }
    }
  });
}

$(function() {
  $('.dataTables-example').DataTable({
    pageLength: 25,
    responsive: true,
    aaSorting: [],
    dom: '<"html5buttons"B>lTfgitp',
    buttons: [
      {extend: 'copy'},
      {extend: 'csv'},
      {extend: 'excel', title: 'ExampleFile'},
      {extend: 'pdf', title: 'ExampleFile'},
      {extend: 'print',
        customize: function (win){
          $(win.document.body).addClass('white-bg');
          $(win.document.body).css('font-size', '10px');
          $(win.document.body).find('table')
                              .addClass('compact')
                              .css('font-size', 'inherit');
        }
      }
    ]
  });
});

$(document).on("click", '.amountBtnGroup button', function() {
  $('#wallet_amount').val($(this).val());
});

$(document).on("click", '.reset-pwd-link', function() {
  var random_password_length = 6;

  var random_password = randomPassword(random_password_length);
  
  $('#user_password').val(random_password) 
});

function randomPassword(length) {
    var chars = "abcdefghijklmnopqrstuvwxyz1234567890";
    var pass = "";
    for (var x = 0; x < length; x++) {
        var i = Math.floor(Math.random() * chars.length);
        pass += chars.charAt(i);
    }
    var random_number = Math.floor(100 + Math.random() * 900);
    pass = pass + random_number
    return `&${pass}`;
}

function searchContent(address) {
  $('.search_btn').on('click', function() {
    commonSearchCode(address);
  });
  // $('#transaction_type').on('change', function() {
  //   commonSearchCode(address);
  // });
}

function commonSearchCode(address, start='', end='') {
  var startDate;
  var endDate;
  if ($('.query').length > 0) {
    query = $.trim($('.query').val());
  } else {
    query = $.trim($("#transaction_type").find(":selected").val());
  }
  min_amt = parseInt($.trim($('.min_amt').val()));
  max_amt = parseInt($.trim($('.max_amt').val()));
  min_amt = min_amt ? parseInt(min_amt) : '';
  max_amt = max_amt ? parseInt(max_amt) : '';
  amt_type = $.trim($("#amt_type").find(":selected").val());
  order = $.trim($("#arrange-items").find(":selected").val());
  dateRangePicker = $(".date-range").data('daterangepicker');
  if (start) startDate = start;
  if (end) endDate = end;
  if (dateRangePicker) {
    startDate = dateRangePicker.startDate.format('YYYY-MM-DD');
    endDate =  dateRangePicker.endDate.format('YYYY-MM-DD');
  }
  if (min_amt && min_amt < 1) return toastr.error('Minimum amount should be more than 0.');
  if (max_amt && max_amt < 1) return toastr.error('Maximum amount should be more than 0.');
  if (min_amt > max_amt) return toastr.error('Minimum amount should be smaller than maximum amount.');
  //if (query && query.length < 2) return toastr.error('Please search for more than 2 characters.');
  if (query || (min_amt && max_amt) || (startDate && endDate) || order || amt_type) {
    data = { 'query': query };
    if (max_amt) {
      data['min_amt'] = min_amt || 0;
      data['max_amt'] = max_amt;
    }
    if (amt_type) data['amt_type'] = amt_type;
    if (startDate && endDate) {
      data['start_date'] = startDate;
      data['end_date'] = endDate; 
    }
    phone_no = parseInt($.trim($('.phone_no').val()));
    if(phone_no >= 0) {
      data['phone'] = phone_no
    }

    if($("#reseller_user_id").val()) {
      data['reseller_user_id'] = $("#reseller_user_id").val();
    }
    if (order) data['order'] = order;
    $.ajax({
      url: address,
      type: "GET",
      data: data
    });
  } else {
    return toastr.error('Please enter a search query.');
  }
}

function resetSearch(url) {
  $('.reset_btn').on('click', function() {
    document.location.href = url;
  });
}

function onlyNumeric() {
  $(".only-numeric").bind("keypress", function (e) {
    var keyCode = e.which ? e.which : e.keyCode
    if (!(keyCode >= 48 && keyCode <= 57)) {
      return false;
    }       
  });

  $(".only-numeric-omit-zero").bind("keypress", function (e) {
    var keyCode = e.which ? e.which : e.keyCode
    if (!(keyCode >= 48 && keyCode <= 57) || (this.value.length == 0 && keyCode == 48 )) {
      return false;
    }       
    if(this.value.charAt(0) == '0') {
      $(this).val($(this).val().substr(1));
    }
  });

  $('.only-numeric-omit-zero').closest('form').submit(function() {
    el = $('.only-numeric-omit-zero');
    if(el.val().charAt(0) == '0') {
      el.val(el.val().substr(1));
    }
    return true
  });
}
$(document).on('click', 'a.navbar-minimalize', function() {
  var data = {
    navbar_type: !$('body').hasClass('mini-navbar')
  }
  
  postAjaxJs('/admin/gammabet_setting/navbar_type', data);
})

$(document).ready(function() {
  $('.filter-table').closest('.ibox-content').find('input').keypress(function(e) {
    var keyCode = e.which ? e.which : e.keyCode
    if(keyCode == 13)
      $(this).closest('.ibox-content').find('button.search').click();
  });
});