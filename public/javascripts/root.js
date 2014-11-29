console.log('root.js loaded')

$(document).ready(function() {
  $('#form').on('submit', function(e) {
    e.preventDefault();
    var text = $('#textarea').val();
    $.ajax({
      type: "POST",
      url: "/",
      dataType: "json",
      data: {text: text}
    }).done(function(data){
      console.log(data);
      $('#textcontent').html(data['phrase'])
      $('#accuracy').text(data['accuracy']+"% Accuracy")
      $('#outof').text("The student got "+data['correct']+" correct & "+data['incorrect']+" incorrect out of "+data['total']+" words.")
    });
  });
});
