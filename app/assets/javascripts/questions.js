function progressBarEvents() {
  $('.progress-point').on('click', function () {
    var question_target = $(this).data('number');
    console.log(question_target);
    var question_current = $('.active').data('number')
    console.log(question_current);
    var n = question_target - question_current
    console.log(n);
    if (n > 0) {
      for (var i = 0; i < n; i += 1) {
        setTimeout(function() {
          navigateup();
        }, 100);
      };
    } else {
      for (var i = 0; i > n; i -= 1) {
        setTimeout(function() {
          navigatedown();
        }, 100);
      };
    }
  });
}

$(document).ready(function() {
  $('.prev').on('click', function() {
    navigatedown();
  })
  $('.next').on('click', function() {
    navigateup();
  })

  $(document).keydown(function (e)
  {
      var keycode1 = (e.keyCode ? e.keyCode : e.which);
      if (keycode1 == 0 || keycode1 == 9) {
          e.preventDefault();
          e.stopPropagation();
      }
  });

  $("form.questionnaire-form").on("submit", function(e) {
    e.preventDefault();
    return false;
  })

  if ($('#questions').length > 0) {
    // réponses des questions à choix multiple
    $('.answer').on('click', function() {
      $(this).parents(".question-container").find(".answer").removeClass('select').addClass('hover');
      $(this).addClass('select');
      var value = $(this).data('input');
      $(this).parent().prev().children('input').val(value).trigger("change");
    });

    progressBarEvents();

    // ecoute l'event change sur chaque input
      // au change $.ajax => trigger procedures_controller#update

   $('input').on('change', function() {
      var column = $(this).data('column');
      var value = $(this).val();
      var procedure_id = $("#questions").data("procedure-id");
      var params = {};

      if ($(this).attr("type") == "file") {
        var params = new FormData();
        params.append(column, $(this)[0].files[0]);

        $.ajax({
          url: '/procedures/' + procedure_id + '.js?file=true',
          type: 'patch',
          processData: false,
          contentType: false,
          data: params,
          success: function(data) {
            console.log("coucou4");
          }
        });
      } else {
        params[column] = value;
        $.ajax({
          url: '/procedures/' + procedure_id + '.js',
          type: 'patch',
          data: { procedure: params },
          success: function(data) {
            console.log("coucou4");
          }
        });
      }

      // console.log("coucou3");
      // debugger

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
  question.prev().slideDown().css('display', 'flex');
}


// var question_number = $(this).parent().data('number');
// $('.progress-point[data-number="'+question_number+'"]').removeClass('fa-circle-thin').addClass('fa-times-circle');
