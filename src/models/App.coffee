# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

# Stand logic:
# - reveal dealer card
# - compare scores
# - announce winner
# - reset game

# on round end, trigger notification with score
# push score into "previous scores" array

class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new Game()
    @get('game').on 'notifyWinner', (winner) =>
      @alertWinner(winner)
    @get('game').on 'recordScores', (scores) =>
      @storeScores(scores)
    @storage = []
    @set 'pastScores', @storage

  alertWinner: (winner) ->
    alert "#{winner} wins!"

  storeScores: (scores) ->
    @storage.push(scores)
    @set 'pastScores', @storage
    @trigger 'reRender'
