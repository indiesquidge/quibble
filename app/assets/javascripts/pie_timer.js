$(document).ready(function() {
  var roomPage = '/rooms/';

  function isOpenRoom() {
    if (($("p#pending").html()) || ($("p#active").html())) {
      return true;
    } else {
      return false;
    }
  }

  if( window.location.href.includes(roomPage) && isOpenRoom()) {

    ;(function(w) {

      'use strict';

      Date.now //fix by Ari Fuchs, afuchs.tumblr.com/post/23550124774/date-now-in-ie8

      Date.now = Date.now || function() { return + new Date };

      var loader = document.getElementById('loader'),
        border = document.getElementById('border');

      function saveAnimationState(rate) {
        $.ajax({
          dataType: 'text',
          type: 'post',
          url: '/animation_catcher',
          data: { time_left: rate,
            slug: window.location.pathname.slice(7) },

        });
      }

      function drawFromDatabase(element) {
        var room = window.location.pathname.slice(7)
        $.ajax({
          type: 'get',
          url: '/send_animation?slug=' + room,
          success: function(rate) {
             rate = parseInt(rate);
            return draw(element, rate);
          }
        });
      }

      function draw(element, rate) {
        var count = element.length,
          angle = 360 * rate;

        angle %= 360;

        var rad = (angle * Math.PI / 180),
          x = Math.sin(rad) * 125,
          y = Math.cos(rad) * - 125,
          mid = (angle > 180) ? 1 : 0,
          shape = 'M 0 0 v -125 A 125 125 1 '
        + mid + ' 1 '
        +  x  + ' '
        +  y  + ' z';

        if(element instanceof Array)
          while(count--)
            element[count].setAttribute('d', shape)
        else
          element.setAttribute('d', shape)
      }

      w.svgPieTimer = function(props) {

        var element  = props.element,
            duration = 100000,
            n = 1;

        var end = Date.now() + duration * n,
          totaldur = duration * n;

        (function frame() {
          var current = Date.now(),
            remaining = end - current,

            rate = n + 1 - remaining / duration;

          if(remaining < 60) {
            closeRoom();

            draw(element, n - 0.0001);
            if(remaining < totaldur && n) return
          }

        if(rate === 1) {
            drawFromDatabase(element)
        } else if(rate > 1.9220) {
          closeRoom();
          replaceCurrentState();
          showFullPie();
          return;
        } else {
          // saveAnimationState(rate);
          draw(element, rate);
        }

        requestAnimationFrame(frame);

        }());
      }

    })(window, undefined);

    var loader = document.getElementById('loader'),
      border = document.getElementById('border');

    svgPieTimer({
      element: [loader, border],
    });
  } else {
    showFullPie();
  }

});

function closeRoom() {
  $.ajax({
    type: 'put',
    url: window.location.href,
    success: function(choice) {
      showChoice(choice.title);
    }
  });
}

function showChoice(choice) {
 choices = $('#choices').find('h5')
 chosen = choices.filter(function() { return $(this).text() === choice})
 choices.parent().addClass('red-text text-lighten-4 strikethrough')
 chosen.parent().removeClass('red-text text-lighten-4 strikethrough').addClass('green-text text-lighten-1 bold')
}

function replaceCurrentState() {
  var newState = '<h5 class="center-align" id="closed">Closed</h5>'
  $('#state-of-room').children().remove();
  $('#state-of-room').append(newState);
  $('#message_body').remove();
  $('#submit-msg').remove();
  $('#manual-close').remove();
}

function showFullPie() {
  $('#full-pie').css('display', 'block')
}
