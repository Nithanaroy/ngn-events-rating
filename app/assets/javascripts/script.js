var generic_error_msg = 'Something went wrong. We are working on it!';

function update_notice(notice_ref, html) {
    $(notice_ref).fadeOut(100).html(html).fadeIn(100);
}

function notify_error(notice_ref, text) {
    var html = '<p class="alert alert-danger">' + text + '</p>';
    $(notice_ref).fadeOut(100).html(html).fadeIn(100);
}

window.onload = function () {
    document.getElementById('theater').onclick = function(event) {
        return false;
    };
}