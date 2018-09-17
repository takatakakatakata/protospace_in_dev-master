$(function(){
  function Build_Comment_html(comment){
  var html = `${comment.text}`
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
      $('.comment_list').append(html);
      $('#comment_button').prop("disabled",false);
      $('#comment_field').val("");
      })
    .fail(function(){
      alert('通信失敗');
    });
  });
});
