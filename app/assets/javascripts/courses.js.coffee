$(document).ready ->
  $(".course-btn").on "click", (event) ->
    $(this).toggleClass 'active'
    $(this).text (i, text) ->
      (if text is "Delete" then "Subscribe" else "Delete")
    return
  $("#edit-student-btn").on "click", (event) ->
    $(this).toggleClass 'active'
    $(".edit-student-form").toggleClass 'hidden'
  $("#create-group-btn").on "click", (event) ->
    $(this).toggleClass 'active'
    $(".create-group-form").toggleClass 'hidden'