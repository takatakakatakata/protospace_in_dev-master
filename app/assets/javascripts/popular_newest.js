$(function(){
  function build_html(prototype){
    var img = `<img src="${prototype.image.url}">`
    var html = `<div class="col-sm-4 col-md-3 proto-content">
                  <div class="thumbnail">
                    <a href="/prototypes/${prototype.id}">${img}</a>
                    <div class="caption">
                      <h3>${prototype.title}</h3>
                      <div class="proto-meta">
                        <div class="proto-user">
                          <a href="/users/${prototype.user_id}">${prototype.user_name}</a>
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

  window.onpopstate = function(event){
    if (event.persisted) {
       window.location.reload();
     }
   };

  ["popular","newest"].forEach(function(type){
    $('#'+type+'_button').on("click",function(e){
    e.preventDefault();
    var current_url = $(this).attr('href');
    history.replaceState(null, null, current_url);
    $.ajax({
      url:"/prototypes/"+type,
      dataType: "json",
      type:"GET"
    })
    .done(function(json){
      $('.protolists').empty();
      $('.removelist').remove();
      $('.paginate').remove();
      json.prototypes.forEach(function(prototype){
        var html = build_html(prototype);
        $('.protolists').append(html);
      });
      var current_page_url = window.location.href;
        history.pushState(null,null, current_page_url)
    })
    .fail(function(){
      alert("並び替えに失敗しました");
    });
  });
  })

});
