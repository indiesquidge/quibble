$(document).ready(function () {
  var windowLocation = window.location;

  var host;
  var path = windowLocation.pathname.slice(7);

  if (windowLocation.toString().indexOf('192.241.203.99') !== -1) {
    host = 'http://192.241.203.99:4200';
  } else {
    host = 'http://localhost:4200';
  }

  var socket = io(host + '/' + path);

  socket.on('message', function (data) {
    var message = JSON.parse(data);
    appendMessage(message);
  });
});
