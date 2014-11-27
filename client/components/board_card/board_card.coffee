# client/components/board_card/board_card.coffee
Template.boardCard.helpers
  panelStyle: ->
    bg = @background?.thumb
    bg && "background-image: url(#{bg})" || ''

Template.boardCard.events
  "click button.close": (event, template) ->
    bootbox.confirm "Are you sure that you want to remove this board?", (r)->
      if !r
        return true
      template.data.removeBoard ->
        alertify.success "Board was removed"