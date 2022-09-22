$('.enabled_market').on('click', function(event){
  elem = $(this);
  var result = confirm("Are you sure?");
  if (result) {
    id = elem.attr("data").split("_")[1];
    match_id = elem.attr("data-match-id");
    let url = "/admin/markets/update_sport_market"
    visible =  elem.is(":checked")
    $.ajax({
      url: url,
      type: 'PATCH',
      data: {sm_id: id, match_id: match_id, 'sport_market': {'visible': visible}},
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

$('.priority-select').on('change', function() {
  const path = "/admin/markets/update_sport_market";
  const element = this;
  const initialPriority = this.dataset.initialValue;
  const sportMarketId = this.dataset.sportMarketId;
  const priority = this.value;
  const data = {
    sm_id: sportMarketId,
    sport_market: {
      priority: priority
    }
  }

  $.ajax({
    type: 'PATCH',
    url: path,
    data,
    success(data) {
      element.dataset.initialValue = priority;
      toastr.success(data.message);
    },
    error() {
      element.value = initialPriority;
      toastr.error("Can't change priority!");
    }
  });
});

$('.pagination a').attr('data-remote', 'true');