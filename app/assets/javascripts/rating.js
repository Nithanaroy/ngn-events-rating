//
// Written especially to manage the star based rating for events show page

$(function() {
    var url = $(location).attr('href');
    var event_id = url.substring(url.lastIndexOf("/") + 1).split('?')[0]; // TODO: Better way to handle getting the event_id

    /**
     * START: Managing rating animation and saving on to server
     */
    var rating = get_rating(); // Save the rating if already rated on page load
    var empty_star = 'glyphicon-star-empty';
    var filled_star = 'glyphicon-star';
    var stars = $("#event-show .rating span"); // Get all stars

    // Handle the filling of rating stars on mouse over
    $(stars).hover(function () {
        var index = $(stars).index(this);
        set_rating(index + 1);
    }, function () {
        set_rating(rating);
    });

    // Submit the rating to server
    $(stars).click(function () {
        $.ajax({
            url: event_id + "/rating",
            method: "POST",
            data: {"rating": get_rating()},
            success: function (data, ui) {
                update_notice($("#event-show #notice"), data);
                rating = get_rating(); // Save the rating for restoring filled stars after hover affect
            },
            error: function () {
                notify_error($("#event-show #notice"), generic_error_msg);
                set_rating(rating); // restore old rating back
            }
        });
    });

    // Gets the rating based on number of stars filled
    function get_rating() {
        return $(stars).filter('.' + filled_star).length;
    }

    function set_rating(_rating) {
        $(stars).removeClass(filled_star).addClass(empty_star);
        $(stars).slice(0, _rating).removeClass(empty_star).addClass(filled_star);
    }

    /**
     * END: Managing rating animation and saving on to server
     */
});