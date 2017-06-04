$(document).ready(function() {
  if ($('#questions').length > 0) {
    $('.answer').on('click', function() {
      $('.active').removeClass('active');
      $(this).addClass('active');
      var value = $(this).data('input');
      $(this).parent().prev().children('input').val(value);
    });

    $('.next').on('click', function() {
      $(this).parent().slideUp();
    })
    $('.prev').on('click', function() {
      $(this).parent().prev().slideDown().css('display', 'flex');
    })
  }
})
