$(document).ready ->
  $(".course-btn").on "click", (event) ->
    $(this).toggleClass 'active'
    $(this).text (i, text) ->
      (if text is "Delete" then "Add course" else "Delete")
    return
  return