$(document).on('turbolinks:load', function () {
    $('.comments-area.comments').on('click', '.edit-comment-link', function (e) {
        e.preventDefault();
        $(this).hide();
        var commentId = $(this).data('commentId');
        $('div#edit-comment-' + commentId).show();
    })
});
