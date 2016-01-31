    assert = chai.assert
    expect = chai.expect

    describe 'app', ->
      app = null

      beforeEach ->
        app = new App()

      describe 'storeScores', ->
        it 'should increase length of storage', ->
          app.storeScores([14, 17])
          expect(app.storage.length).to.equal(1)

        it 'should add score to pastScores', ->
          app.storeScores([12, 20])
          expect(app.get('pastScores')[0][0]).to.equal(12)

