$(document).ready(function() {
  $('.select-item').on('click', function() {
    $('.active').removeClass('active');
    $(this).addClass('active');
    var value = $(this).text();
    $(this).parent().prev().children('input').val(value);
  })
})
