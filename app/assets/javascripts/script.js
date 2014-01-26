var generic_error_msg = 'Something went wrong. We are working on it!';

function update_notice(notice_ref, html) {
    $(notice_ref).fadeOut(100).html(html).fadeIn(100);
}

function notify_error(notice_ref, text) {
    var html = '<p class="alert alert-danger">' + text + '</p>';
    $(notice_ref).fadeOut(100).html(html).fadeIn(100);
}

function handle_ajax_error(error) {
	error_msg = generic_error_msg;
	if(error.status == 401)
        error_msg = error.responseText;
    notify_error($("#notice"), error_msg);
}