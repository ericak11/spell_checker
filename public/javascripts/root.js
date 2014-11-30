console.log('root.js loaded');

$(document).ready(function() {
  $('#form').on('submit', function(e) {
    e.preventDefault();
    clearContentArea();
    var text = $('#textarea').val();
    $.ajax({
      type: "POST",
      url: "/",
      dataType: "json",
      data: {text: text}
    }).done(function(data){
      $('#textcontent').html(data.phrase);
      if (data.accuracy > 75) {
        $('#accuracy').text(data.accuracy+"% Accuracy").addClass('green').removeClass('red');
      } else {
        $('#accuracy').text(data.accuracy+"% Accuracy").addClass('red').removeClass('green');
      }
      $('#total').text("Total Words: "+data.total);
      $('#correct').text("Correct: "+data.correct);
      $('#incorrect').text("Incorrect: "+data.incorrect);
      $('#error').text("");
      $('#submit').show();
    });
  });
});

$( document ).ajaxError(function() {
  $('#error').text("An error occured, Please try again.");
  $('#submit').show();
});

function clearContentArea() {
  $('#total').text("");
  $('#correct').text("");
  $('#incorrect').text("");
  $('#accuracy').text("");
  $('#textcontent').text("");
  $('#error').text("Spell Checking...");
  $('#submit').hide();
}
