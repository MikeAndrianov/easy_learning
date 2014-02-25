$(document).ready ->
  $(".day").on "click", (event) ->
    $.ajax 
      url: "/events/new"
      type: 'GET'
      dataType: 'script'
      data: {
        'day': $(this).attr('day')
      }
