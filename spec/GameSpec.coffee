assert = chai.assert
expect = chai.expect

describe 'game', ->
  game = null

  beforeEach ->
    game = new Game()

  it 'should have a deck with 48 cards after dealing initial hands', ->
    deck = game.get('deck')
    assert.strictEqual deck.length, 48

  # describe 'getScores', ->
  #   it 'should call getScore', ->
  #     sinon.spy game, 'getScore'
  #     game.compareScores([10, 20], [17, 0])
  #     expect(game.getScore).to.have.been.called

  describe 'compareScores', ->
    it 'should call getScore', ->
      sinon.spy game, 'getScore'
      game.compareScores([10, 20], [17, 0])
      expect(game.getScore).to.have.been.called

