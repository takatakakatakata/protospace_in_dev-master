$(function(){
  function build_html(prototype){
    var img = `<img src="${prototype.image.url}">`
    var html = `<div class="col-sm-4 col-md-3 proto-content">
                  <div class="thumbnail">
                    <a href="#">${img}</a>
                    <div class="caption">
                      <h3>${prototype.title}</h3>
                      <div class="proto-meta">
                        <div class="proto-user">
                          <a href="#">${prototype.user_name}</a>
                          <div class="btn btn-default button id="likes_buttons_${prototype.id}">
                          </div>
                        </div>
                        <div class="proto-posted">
                          ${prototype.posted_date}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`
    return html;
  }
  $('#newest_button').on("click",function(e){
    e.preventDefault();
    var current_url = $(this).attr('href');
    history.replaceState(null, null, current_url);
    $.ajax({
      url:"/prototypes/newest",
      dataType: "json",
      type:"GET"
    })
    .done(function(json){
      $('.protolists').empty();
      $('.removelist').remove();
      json.prototypes.forEach(function(prototype){
        var html = build_html(prototype);
        $('.protolists').append(html);
      });
    })
    .fail(function(){
      alert("並び替えに失敗しました");
    });
  });
});
