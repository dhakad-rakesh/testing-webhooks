function enabledOrDisabledMatch() {
  $('.enabled_match').on('click', function(event){
    elem = $(this);
    var result = confirm("Are you sure?");
    if (result) {
      id = elem.attr("data").split("_")[1];
      visible =  elem.is(":checked");
      matchAjaxCall(id, {'visible' : visible});
    } else {
      if (elem.prop('checked') == true) {
        elem.prop("checked", false)
      } else {
        elem.prop("checked", true)
      }
    }
  });
};

function setOrUnsetHighlightMatch() {
  $('.highlight_match').on('click', function(event){
    elem = $(this);
    var result = confirm("Are you sure?");
    if (result) {
      id = elem.attr("data").split("_")[1];
      highlight =  elem.is(":checked");
      matchAjaxCall(id, {'highlight' : highlight});
    } else {
      if (elem.prop('checked') == true) {
        elem.prop("checked", false)
      } else {
        elem.prop("checked", true)
      }
    }
  });
};

function matchAjaxCall(id, data) {
  $.ajax({
    url: "/admin/matches/" + id,
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

function searchContent(address) {
  $('.search_btn').on('click', function() {
    commonSearchCode(address);
  });
  $('#match_kind').on('change', function() {
    commonSearchCode(address);
  });
}

function commonSearchCode(address) {
  query = $.trim($('.search').val());
  kind = $.trim($("#match_kind").find(":selected").val());
  if (query || kind) {
    data = {};
    if (query) data['query'] = query;
    if (kind) data['kind'] = kind;
    $.ajax({
      url: address,
      type: "GET",
      data: data
    });
  } else {
    return toastr.error('Please enter a search query.');
  }
}