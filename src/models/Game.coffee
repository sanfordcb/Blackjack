# Game Logic here
# Notes:
# We're assuming the dealer stands on all 17's ( soft or not )

# Make rendered score reflect ace correctly
# Refresh game at round end
  # Use same shuffled stack for each round
# either do chips or user experience

class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', @roundEnd
    @get('playerHand').on 'playerBust', =>
      @newRound();
      @notifyWinner('Dealer')
    @get('playerHand').on 'outOfCards', @makeNewDeck
    @get('dealerHand').on 'outOfCards', @makeNewDeck

  roundEnd: =>
    @get('dealerHand').each (card) ->
      if not card.get 'revealed' then card.flip()
    @dealerRoundEnd()
    winner = @compareScores(@get('playerHand').scores(), @get('dealerHand').scores())
    @notifyWinner(winner)
    @newRound()

  notifyWinner: (winner) ->
    if winner then @trigger 'notifyWinner', winner

  recordScores: ->
    playerScore = @getScore(@get('playerHand').scores())
    dealerScore = @getScore(@get('dealerHand').scores())
    @trigger 'recordScores', [playerScore, dealerScore]

  newRound: ->
    @recordScores()
    if @get('deck').length < 4 then @makeNewDeck()
    @get('playerHand').reset([@get('deck').pop(), @get('deck').pop()])
    @get('dealerHand').reset([@get('deck').pop().flip(), @get('deck').pop()])

  makeNewDeck: =>
    @set 'deck', deck = new Deck()
    @get('playerHand').deck = deck
    @get('dealerHand').deck = deck

  compareScores: (playerScore, dealerScore) ->
    playerScore = @getScore(playerScore)
    dealerScore = @getScore(dealerScore)
    if dealerScore > 21 then 'Player'
    else if playerScore is dealerScore then false
    else if playerScore > dealerScore then 'Player' else 'Dealer'

  getScore: (score) ->
    if not score[1]
      score[0]
    else if score[0] > 21
      score[1]
    else if score[1] > 21
      score[0]
    else if score[0] > score[1] then score[0] else score[1]

  dealerRoundEnd: () ->
    score = @getScore(@get('dealerHand').scores())
    if score > 17 then undefined else @get('dealerHand').hit()
    if score > 17 then undefined else @dealerRoundEnd()
