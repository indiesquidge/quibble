$(document).ready(function () {
  var socket = io.connect('http://localhost:4200');

  socket.on('message', function (data) {
    var message = JSON.parse(data);
    appendMessage(message);
  });
});
