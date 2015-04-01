var options = {
  clientSideStorage: false,
  textarea: "post_content"
};

var editor = new EpicEditor(options).load();

$("#post_content").hide();

$(".js-blog-form").on("submit", function(){
  var content = editor.exportFile();
  $("#post_content").val(content);
});
