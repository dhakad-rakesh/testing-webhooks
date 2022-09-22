$(function(){
  var dateFormat = $('.date-range').data('time-picker') ? 'DD-MM-YYYY HH:mm:ss' : 'DD-MM-YYYY';
  $('[data-behavior=daterangepicker]').daterangepicker({
    ranges: {
      'Today': [moment(), moment()],
      'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
      'Last 7 Days': [moment().subtract(6, 'days'), moment()],
      'Last 30 Days': [moment().subtract(29, 'days'), moment()],
      'This Month': [moment().startOf('month'), moment()],
      'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
      'All Time': [moment().subtract(100, 'years').startOf('year'), moment()],
    },
    timePicker24Hour: $('.date-range').data('time-picker') ? true : false,
    timePickerSeconds: true,
    autoUpdateInput: false,
    locale: { format: dateFormat },
    cancelLabel: 'Clear'
  });

  $('[data-behavior=daterangepicker]').on('apply.daterangepicker', function(ev, picker) {
    start_date = picker.startDate.format(dateFormat);
    end_date = picker.endDate.format(dateFormat);
    $(this).parent().find('.start-date').val(start_date);
    $(this).parent().find('.end-date').val(end_date);
    $(this).val(`${start_date} - ${end_date}`);
  });

  $('[data-behavior=daterangepicker]').on('cancel.daterangepicker', function(){
    $(this).val(' ');
  });
});