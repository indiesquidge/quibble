/*! SVG Pie Timer 0.9.1 | Anders Grimsrud, grint.no | MIT License | github.com/agrimsrud/svgPieTimer.js */

$(document).ready(function() {
  var roomPage = '/rooms/';
  if( window.location.href.includes(roomPage)) {

    ;(function(w) {

      'use strict';

      Date.now //fix by Ari Fuchs, afuchs.tumblr.com/post/23550124774/date-now-in-ie8

      Date.now = Date.now || function() { return + new Date };

      function closeRoom() {
        $.ajax({
          dataType: 'text',
          type: 'put',
          url: window.location.href,
           // success: window.location.reload(),
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

        var element = props.element,
          duration = 1000,
          n = 1;

        // Optional warning

        if(!element) throw "SVG Pie Timer: Error - element required"

          var end = Date.now() + duration * n,
            totaldur = duration * n;

          (function frame() {
            var current = Date.now(),
              remaining = end - current,

              rate = n + 1 - remaining / duration;

            if(remaining < 60) {

              draw(element, n - 0.0001);
              closeRoom();
              if(remaining < totaldur && n) return
            }

            $.ajax({
              dataType: 'text',
              type: 'post',
              url: '/animation_catcher'
            });

            draw(element, rate);

            requestAnimationFrame(frame);
          }());
      }

    })(window, undefined);

    var loader = document.getElementById('loader'),
      border = document.getElementById('border');

    svgPieTimer({
      element: [loader, border],
    });
  }
});
