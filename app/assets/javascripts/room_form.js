var ENTER_KEY = 13;

$(document).ready(function() {
  renderForm();

  $('.choice-field').on('keyup', handleKeypress);
  $('#add-input-field').on('click', handleClick);
  $('.room-submit').on('click', handleSubmit);
});

function formMarkup() {
  return '<h5>New Room</h5>' + buildInput({ className: 'topic-field', placeholder: 'Topic: ex. testing, quotations, workflow' }) +
    buildInput({ className: 'choice-field', placeholder: 'Choice: ex. rspec, minitest, mrspec' }) +
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
    type: 'POST',
    url: '/rooms',
    data: requestBody,
    dataType: 'json',
    success: function(data) {
      window.location = '/rooms/' + data.slug
    },
    error: function() {
      $('#new-room-form').
        append('<p class="materialize-red lighten-1 error">Inputs cannot be blank</p>');
    },
  });
}

function handleClick() {
  if (!$('.choice-field').last().val()) {
    return;
  }
  appendNewInput();
}

function handleKeypress(e) {
  if (e.keyCode === ENTER_KEY) {
    if (!$(this).val()) {
      return;
    }
    appendNewInput();
  }
}

function buildInput(options) {
  var btn;

  if (options.className === 'choice-field') {
    btn = '<a class="btn" id="add-input-field">+</a>';
  } else {
    btn = ''
  }
  return '<div><input type="text" class="' + options.className + '" id= "' + options.className + '"' +
         ' required="require" placeholder="' +
         options.placeholder + '">' + btn + '</div>'
}

function renderForm() {
  $('#new-room-form').append(formMarkup());
}

function appendNewInput() {
  var $input = $(buildInput({ className: 'choice-field', placeholder: 'Choice: ex. rspec, minitest, mrspec' }));
  $input.on('keyup', handleKeypress);
  $input.insertBefore('.room-submit');
  $('#add-input-field').first().remove();
  $('#add-input-field').on('click', handleClick);
}
