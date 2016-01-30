assert = chai.assert

describe 'game', ->
  game = null

  beforeEach ->
    game = new Game()

  it 'should have a deck with 48 cards after dealing initial hands', ->
    deck = game.get('deck')
    assert.strictEqual deck.length, 48

  # describe 'hit', ->
  #   it 'should give the last card from the deck', ->
  #     assert.strictEqual deck.length, 50
  #     assert.strictEqual deck.last(), hand.hit()
  #     assert.strictEqual deck.length, 49
