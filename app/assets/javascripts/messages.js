$(document).ready(function (){
  getMessages();
  createMessageOnSubmission();
});

var MessageRepo = {
  all: function () {
    return $.getJSON('/messages', { slug: window.location.pathname.slice(7) });
  },
  create: function (data) {
    return $.post('/messages', data);
  },
};

function getMessages() {
  MessageRepo.all().then(function (messages) {
    var renderedMessages = messages.map(renderMessage);

    $('.messages tbody').append(renderedMessages);
  });
}

function createMessageOnSubmission() {
  var $submit = $('#new-message').find('input[type="submit"]');
  $submit.on('click', function (event) {
    event.preventDefault();
    createMessage();
    $('form')[0].reset();
  });
}

function createMessage() {
  var body    = $('#message-body').val();
  var room_id = $('#room').val();
  MessageRepo.create({message: { body: body, room_id: room_id }})
    .then(appendMessage);
}

function appendMessage(data) {
  console.log(data);
  var messageMarkup = renderMessage(data);
  $('.messages tbody').append(messageMarkup);
}

function renderMessage(data) {
  return $(
      '<tr>' +
      '<td style="word-wrap: break-word">' + data.body + '</td>' +
      '</tr>'
      );
}
