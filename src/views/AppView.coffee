class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="previousScores"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()

  initialize: ->
    @model.on 'reRender', =>
      @render()
    @render()

  render: ->
    console.log @model
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get('playerHand')).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get('dealerHand')).el
    @$('.previousScores').html @model.get('pastScores').map (scores) =>
      return "<div> #{scores[0]} #{scores[1]} </div>"

