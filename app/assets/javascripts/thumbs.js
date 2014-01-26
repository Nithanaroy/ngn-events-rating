// Implemented wrt events show page

$(function() {
    var url = $(location).attr('href');
    var event_id = url.substring(url.lastIndexOf("/") + 1).split('?')[0]; // TODO: Better way to handle getting the event_id

    var voted_class = 'voted';
    var going_class = '.glyphicon-thumbs-up';
    var not_going_class = '.glyphicon-thumbs-down';
    var button_ref = '#event-show .thumbs button';

    $(button_ref).click(function () {
        var clicked_button = this;
        var going = $(clicked_button).children(going_class).length > 0 ? true : false;
        $.ajax({
            url: event_id + "/going",
            method: "POST",
            data: {"going": going},
            success: function (data, ui) {
                update_notice($("#event-show #notice"), data);
                clear_thumbs_vote();
                $(clicked_button).addClass(voted_class);
            },
            error: function (error, ui) {
                handle_ajax_error(error)                
                clear_thumbs_vote();
            }
        });
    });

    function clear_thumbs_vote() {
        $(button_ref).removeClass(voted_class);
    }

    function disable_thumbs() {
        $(button_ref).attr('disabled', true);
        $(window).focus();
    }

    function enable_thumbs() {
        $(button_ref).attr('disabled', false);
        $(window).focus();
    }
})