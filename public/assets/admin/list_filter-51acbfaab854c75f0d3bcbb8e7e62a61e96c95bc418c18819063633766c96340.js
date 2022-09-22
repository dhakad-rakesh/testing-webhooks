$(function(){
  var dateFormat = $('.date-range').data('time-picker') ? 'DD-MM-YYYY HH:mm:ss' : 'DD-MM-YYYY';
  $('[data-behavior=daterangepicker]').daterangepicker({
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
