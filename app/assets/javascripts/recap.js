$(".recap-file-upload[type=file]").change(function(){
  var form = $(this).parents("form:first");
  form.trigger('submit');
});
