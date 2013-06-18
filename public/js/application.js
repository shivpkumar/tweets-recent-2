$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  if ($('.waiting_message.tweets').length !== 0) {
    $.ajax({
      method: 'POST',
      url: window.location.pathname + '/tweets'
    }).done(function(htmlPartial){
      $('.tweets').remove();
      $('.waiting_message').remove();
      $('.container').append(htmlPartial);
    });
  }

   if ($('.waiting_message.info').length !== 0) {
    $.ajax({
      method: 'POST',
      url: window.location.pathname
    }).done(function(htmlPartial){
      console.log("test");
      $('.waiting_message.info').remove();
      $('.bio').remove();
      $('.container').append(htmlPartial);
    });
  }

  $('#submit_tweet_form').on('submit', function(e) {
    e.preventDefault();
    
    var formData = $(this).serialize();
    $(this).children().attr('disabled', 'disabled');
    $(this).next().show();
    $('.message').remove();

    $.ajax({
      type: 'post',
      url: '/tweet',
      data: formData
    }).done(function(response) {
      console.log(response);
      $('#submit_tweet_form').children().removeAttr('disabled');
      $('#submit_tweet_form').next().hide();
      if (response == "200") {
        $(".container").append("<p class='message'>Your tweet was posted successfully!</p>");
      }
      else
      {
        $(".container").append("<p class='message'>There was an error processing your tweet...</p>");
      }
      setTimeout(function(){$('.message').animate({ opacity: '0' }, 1000);}, 1000);
    });
  });


});
