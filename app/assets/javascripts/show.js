$(function () {

    var url = $(location).attr('href');
    var event_id = url.substring(url.lastIndexOf("/") + 1); // TODO: Better way to handle getting the event_id

    $("#show #rating").change(function () {
        $.ajax({
            url: event_id + "/rating",
            method: "POST",
            data: {"rating": $(this).val()},
            success: function () {
                $("#show #notice").text("Your rating has been saved");
            },
            error: function () {

            }
        });
    });
});