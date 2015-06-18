var ENTER_KEY = 13;

$(document).ready(function() {
  renderForm();

  $('.choice-field').on('keyup', handleKeypress);
  $('.room-submit').on('click', handleSubmit);
});

function formMarkup() {
  return buildInput({ className: "topic-field", placeholder: "Topic: ex. testing, quotations, workflow" }) +
    buildInput({ className: "choice-field", placeholder: "Choice: ex. rspec, minitest, mrspec" }) +
    '<button type="submit" class="room-submit btn">Create Room</button>';
}

function handleSubmit(e) {
  e.preventDefault();

  var topic = $('.topic-field').val();
  var choices = [];
  $('.choice-field').each(function(_, input) {
     choices.push($(input).val());
  });
  var requestBody = {
    room: {
      name: topic,
      choices: choices
    }
  };

  $.ajax({
    type: "POST",
    url: "/rooms",
    data: requestBody,
    dataType: 'json',
    success: function(data) {
      window.location = "/rooms/" + data.slug
    }
  });
}

// TODO: Refactor raw text into better jquery syntax:
// $( "<div/>", {
//   "class": "test",
//   text: "Click me!",
//   click: function() {
//     $( this ).toggleClass( "test" );
//   }
// });
function buildInput(options) {
  return '<input type="text" class="' + options.className +
    '" required="require" placeholder="' + options.placeholder + '">';
}

function handleKeypress(e) {
  if (e.keyCode === ENTER_KEY) {
    if (!$(this).val()) {
      return;
    }
    appendNewInput();
  }
}

function renderForm() {
  $('#new-room-form').append(formMarkup());
}

function appendNewInput() {
  var $input = $(buildInput({ className: "choice-field", placeholder: "Choice: ex. rspec, minitest, mrspec" }));
  $input.on('keyup', handleKeypress);
  $input.insertBefore('.room-submit');
}
