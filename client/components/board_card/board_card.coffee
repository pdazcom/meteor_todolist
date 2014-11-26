# client/components/board_card/board_card.coffee
Template.boardCard.helpers
  panelStyle: ->
    bg = @background?.thumb
    bg && "background-image: url(#{bg})" || ''

Template.boardCard.events
  "click button.close": (event, template, data) ->
    console.log arguments