# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

# Stand logic:
# - reveal dealer card
# - compare scores
# - announce winner
# - reset game

class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new Game()
    @get('game').on 'notifyWinner', (winner) =>
      @alertWinner(winner)

  alertWinner: (winner) ->
    alert "#{winner} wins!"

