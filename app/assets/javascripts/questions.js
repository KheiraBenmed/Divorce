$(document).ready(function() {
  if ($('#questions').length > 0) {
    // réponses des questions à choix multiple
    $('.answer').on('click', function() {
      $('.form-control').removeClass('select').addClass('hover');
      $(this).addClass('select');
      var value = $(this).data('input');
      $(this).parent().prev().children('input').val(value);
    });

    // navigation dans les questions => faire du toggleClass 'active'
    $('.next').on('click', function() {
      var question = $('.question-container.active');
      $('.active').removeClass('active');
      question.next().addClass('active');
      $(this).parent().slideUp();
    });

    $('.prev').on('click', function() {
      var question = $('.question-container.active');
      $('.active').removeClass('active');
      question.prev().addClass('active');
      $(this).parent().prev().slideDown().css('display', 'flex');
    });

   $('.progress-point').on('click', function () {
      var question_target = $(this).data('number');
      var question_current = $('.active').data('number')
      var n = question_target - question_current
      if (n > 0) {
        for (var i = 0; i < n; i += 1) {
          setTimeout(function() {
            navigateup();
          }, 100);
        };
      } else {
        for (var i = 0; i < -(n - 1); i += 1) {
          setTimeout(function() {
            navigatedown();
          }, 100);
        };
      }
   });

    // ecoute l'event change sur chaque input
      // au change $.ajax => trigger procedures_controller#update

   $('input').on('change', function() {
      var column = $(this).data('column');
      var value = $(this).val();
      var procedure_id = $("#questions").data("procedure-id");
      var params = {};
      params[column] = value;
      // console.log("coucou3");
      // debugger
      $.ajax({
        url: '/procedures/' + procedure_id + '.js',
        type: 'patch',
        data: { procedure: params },
        success: function(data) {
          console.log("coucou4");
        }
      });
   });
  }
});


function navigateup() {
  var question = $('.question-container.active');
  $('.active').removeClass('active');
  question.next().addClass('active');
  question.slideUp();
}

function navigatedown() {
  var question = $('.question-container.active');
  $('.active').removeClass('active');
  question.prev().addClass('active');
  question.slideDown().css('display', 'flex');
}


// var question_number = $(this).parent().data('number');
// $('.progress-point[data-number="'+question_number+'"]').removeClass('fa-circle-thin').addClass('fa-times-circle');
