$(document).ready ->
  $("#sign-in").on "click", (event) ->
    $(".login-form").toggleClass 'hidden'
    $(this).toggleClass 'active-element'
    return false

