$(document).on 'click', 'form .remove_word_answers', (event) ->
  $(@).prev('input[type=hidden]').val('1')
  $(@).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(@).data('id'), 'g')
  $(@).before($(@).data('word-answers').replace(regexp, time))
  event.preventDefault()
