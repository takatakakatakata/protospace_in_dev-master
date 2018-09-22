$(function(){
  function Build_Comment_html(comment){
  var current_user_id = $('#current_user_id').val();
  var img_url = $(comment.avatar_url)[0].url;
  var img = `<img src="${img_url}" class="icon">`;
  var prototype_id = $(comment.prototype_id)[0];
  var comment_id = $(comment.id)[0];
  var comment_user_id = $(comment.user_id)[0];
  if(current_user_id == comment_user_id){
    var buttons = `<div class="comment_list--buttons">
                     <a href="/prototypes/${prototype_id}/comments/${comment_id}" class="btn btn-default" data-method="delete" >DELETE</a>
                     <a href="/prototypes/${prototype_id}/comments/${comment_id}/edit" class="btn btn-default">EDIT</a>
                   </div>`;
  } else {
    var buttons = "";
  }
  var html = `<div class="comment_list">
                ${img}
                <h3 class="comment_user_name">
                  ${comment.user_name}
                </h3>
                <p class="comment_text">
                  ${comment.text}
                </p>
                ${buttons}
              </div>`;
  return html;
  }

  $('#new_comment').on('submit',function(e){
    var current_user_id = $('#current_user_id').val();
    e.preventDefault();
    var data = new FormData(this);
    var url = $(this).attr('action');
    if(current_user_id){
    $.ajax({
      data: data,
      type: 'POST',
      dataType:'json',
      url: url,
      processData: false,
      contentType: false
    })
    .done(function(json){
      html = Build_Comment_html(json);
      $('.comment_lists').append(html);
      $('#comment_button').prop("disabled",false);
      $('#comment_field').val("");
      $('html,body').animate({scrollTop:$('.bottom').offset().top},"swift");
      })
    .fail(function(){
      alert('通信に失敗しました');
    });} else{
      var current_url = window.location.href;
      redirect_url = current_url.replace(/prototypes.\d+/,"users/sign_in");
      window.location = redirect_url
    }
  });
});