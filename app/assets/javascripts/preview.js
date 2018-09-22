$(function(){
  //メイン画像ファイルプレビュー表示
  $('#main_image_uploader').on('change', '#main-thumbnail', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#main-preview");
        t = this;
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }
    reader.onload = (function(file) {
      return function(e) {
        var image = new Image();
        image.src = reader.result;
        image.onload = function(){
          $preview.empty();
          $preview.append($('<img>').attr({
            src: e.target.result,
            width: "100%",
            height: "500px"
          }));
        }
      };
    })(file);
    reader.readAsDataURL(file);
  });
  //サブ画像ファイルプレビュー表示
  $('#sub_image_uploader').on('change', '#sub-thumbnail', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#sub-preview-" + String($(this).data('id')));
        t = this;
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }
    reader.onload = (function(file) {
      return function(e) {
        var image = new Image();
        image.src = reader.result;
        image.onload = function(){
          $preview.empty();
          $preview.append($('<img>').attr({
            src: e.target.result,
            width: "100%",
            height: "200px"
          }));
        }
      };
    })(file);
    reader.readAsDataURL(file);
  });
});
