$(document).ready(function() {

  $('#f-email').focus(function(event){
    $(this).animate({width: "170px"});
    // $(this).css("background-color","#bbb");
    if ( $(this).val() == "email" ) {
      $(this).val("");
    };
  });

  $('#f-email').blur(function(event){
    if ( $(this).val() == "" )
      {
        $(this).val("email");
        $(this).animate({width: "100px"});
        // $(this).css("background-color","#999");
      };
  });

  $('#f-password').focus(function(event){
    $(this).animate({width: "140px"});
    // $(this).css("background-color","#bbb");
    $(this).attr("type","password")
    if ( $(this).val() == "password" ) {
      $(this).val("");
    };
  });

  $('#f-password').blur(function(event){
    if ( $(this).val() == "" )
      {
        $(this).animate({width: "100px"});
        $(this).val("password");
        $(this).attr("type","pssword");
        // $(this).css("background-color","#999");
      };
  });

 // $('input').focus(function(event){
 //    // $(this).css("background-color","#bbb");
 //       $(this).val("");
    
 //    if ( $(this).val() == "password" ) {
 //      $(this).attr("type","password");
 //    };
 //  });

  $('.signup form').submit(function(event){
    event.preventDefault();
    var user_input = $(this).serialize();
    $.post('/signup', user_input, function(response){
      if (response == "success")
      {
        // alert(response);
        window.location.href = '/';
      }
      else {
        alert(response);
      }
    });
  });
  
  $('.header form').submit(function(event){
    event.preventDefault();
    var user_input=$(this).serialize();
    $.post('/login', user_input, function(response){
       if (response == "success")
      {
        // alert(response);
        window.location.href = '/';
      }
      else {
        alert(response);
        console.log($(this).val(''));
        $('.header form .field #f-email').val('');
        $('.header form .field #f-password').val('');

      }
    });
  });





  // $(window).scroll(function(){
  //   var scrollTop = 90;
  //   if($(window).scrollTop() >= scrollTop){
  //       $('.header').css({
  //           position : 'fixed',
  //           top : '0'
  //       });
  //   }
  //   if($(window).scrollTop() < scrollTop){
  //       $('.header').removeAttr('style');
  //   }
  // });

  $('#guess').keyup(function(){
    if ($('#embedded_answer').text().toLowerCase() == $('#guess').val().toLowerCase()) {
      $('#correct_banner').show();
    } else {
      $('#correct_banner').hide();
    }
  });

  $('#submit_guess').submit(function(event){
    event.preventDefault();

    var guess = $('#submit_guess').serialize();

    $.post($('#submit_guess').attr('action'), guess, function(response){
      // alert("Well, this at least got here");
      $('.game_container').replaceWith(response);
    });

  });
 
});
