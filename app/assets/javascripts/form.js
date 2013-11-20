$(function () {
    var datetime_picker_properties = {
        dateFormat: "yy-mm-dd",
        timeFormat: "h:mm TT",
//        stepMinute: 15,
        addSliderAccess: true,
        sliderAccessArgs: { touchonly: false }};
    $("#event_from, #event_to").datetimepicker(datetime_picker_properties);
    $("#event_from").datetimepicker("option", "onClose",
        function (selectedDate) {
            $("#event_to").datepicker("option", "minDate", selectedDate);
        });
    $("#event_to").datetimepicker("option", "onClose",
        function (selectedDate) {
            $("#event_from").datepicker("option", "maxDate", selectedDate);
        });

    $('.edit_event div.fileinput a.my-fileinput').click(function() {
       $(this).closest('.fileinput').find('.fileinput-new img').attr('src', 'holder.js/300x300');
        Holder.run();
        $(this).attr('disabled', 'disabled')
        $("#event_remove_image").val('true');
    });
});