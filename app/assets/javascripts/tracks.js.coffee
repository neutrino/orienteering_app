jQuery ($) ->
  $(document).ready ->
    nestedForm = $('.nested_control_points_form').last().clone()

    $('#nested-control-points').on 'click', '.remove_control_point', ->
      $(this).closest('.nested_control_points_form').slideUp().remove()

    $('.add_control_point').on 'click', (e) ->
      e.preventDefault()

      lastNestedForm = $('.nested_control_points_form').last()
      newNestedForm  = $(nestedForm).clone()
      formsOnPage    = $('.nested_control_points_form').length

      $(newNestedForm).find('label').each ->
        oldLabel = $(this).attr 'for'
        newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
        $(this).attr 'for', newLabel

      $(newNestedForm).find('select, input').each ->
        oldId = $(this).attr 'id'
        newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
        $(this).attr 'id', newId

        oldName = $(this).attr 'name'
        newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{formsOnPage}]")
        $(this).attr 'name', newName

      $('.add_control_point').before(newNestedForm)

  $('ul.control-points').sortable
    axis: 'y'
    update: ->
      console.log "hello"

