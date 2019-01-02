/*
|--------------------------------------------------------------------------
|   Load Preview Of Image
|--------------------------------------------------------------------------
*/
var loadFile = function(event) {
  var type = event.target.files[0].type;
  if(type == 'image/jpeg' || type =='image/gif' || type == 'image/png'){
    var output = document.getElementById('image-preview');
    output.src = URL.createObjectURL(event.target.files[0]);
  }
};
/*
|--------------------------------------------------------------------------
|   In Comment Section
|--------------------------------------------------------------------------
*/
$(function(){
  $('div.view_post_bottom>span.comment_counter').click(function(){
    $(this).parent('div.view_post_bottom').siblings('div.post-bottom').slideToggle();
  });
  $('.new_comment').submit(function(){
    $(this).closest('div.comment-like-form').siblings('div.post-bottom').slideDown();
  });
});

// FOR COMMENTS
var Append = {};
Append.open = false;
function ClickableCommentsLink(){
  $('.more-comments').click( function() {
    $(this).on('ajax:success', function(event, data, status,xhr) {
      event.preventDefault();
      var postId = $(this).data("post-id");
      $("#comments_" + postId).html(data);
      $("#comments-paginator-" + postId).html("<a id='more-comments' data-post-id=" + postId + "data-type='html' data-remote='true' href='/posts/" + postId + "/comments>Show more Comments</a>");
      Append.open = true;
      Append.comment = true;
      Append.link = false;
    });
  });
}

function DestroyComments(){
  $('.delete-comment').click( function() {
    Append.id = this;
    Append.post_id = $(this).data("post-id");
    Append.comment_count = $(this).data("value");
  });
}

$( document ).ready(function() {
  ClickableCommentsLink();
  DestroyComments();
  $('.comment_content').click (function(){
    Append.id = this;
    Append.post_id = $(this).data("post-id");
    Append.postable_type = $(this).data("postable-type");
    Append.postable_id = $(this).data("postable-id");
    if (Append.comment_count == undefined){ Append.comment_count = $(this).data("value"); }
    if(Append.comment_count < 4){ Append.comment = true; Append.link = false; }
    else if(Append.comment_count == 4){ Append.comment = false; Append.link = true; }
    else if(Append.comment_count > 4){ Append.comment = false; Append.link = false;  }
  })
});
