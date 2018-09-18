$(function(){
  function Build_Comment_html(comment){
  var img_url = $(comment.avatar_url)[0].url
  var img = `<img src="${img_url}" class="icon">`;
  var prototype_id = $(comment.prototype_id)[0]
  var comment_id = $(comment.id)[0]
  var html = `<div class="comment_list">
                ${img}
                <h3 class="comment_user_name">
                  ${comment.user_name}
                </h3>
                <p class="comment_text">
                  ${comment.text}
                </p>
                <div class="comment_list--buttons">
                <a href="/prototypes/${prototype_id}/comments/${comment_id}" class="btn btn-default" data-method="delete" >DELETE</a>
                <a href="/prototypes/${prototype_id}/comments/${comment_id}" class="btn btn-default">EDIT</a>
                </div>
              </div>
              `
  return html;
  }

  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    var data = new FormData(this);
    var url = $(this).attr('action');
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
      })
    .fail(function(){
      alert('通信失敗');
    });
  });
});
