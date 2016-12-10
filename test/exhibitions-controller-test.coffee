chai = require 'chai'
sinon = require 'sinon'
mockery = require 'mockery'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'Exhibitions Controller', ->
  before ->
    mockery.enable({
      warnOnReplace: false,
      warnOnUnregistered: false
    })

  describe 'getUpcomingExhibitions', ->
    ExhibitionsController = null
    momentSpy = null
    formatSpy = null
    expectedArgs = 'Y-MM-DD'
    exhibBeginDate = '2016-12-19'
    exhibEndDate = '2017-01-05'
    currentDate = '2016-12-20'
    items = [{
      ExhibEndDate: exhibEndDate
      , ExhibBeginDate: exhibBeginDate
    }]

    describe 'Returns back one valid exhibition', ->
      beforeEach ->
        formatSpy = sinon.spy(-> currentDate )
        momentSpy = sinon.spy(-> {
          format: formatSpy
        })
        mockery.registerMock('moment', momentSpy)
        ExhibitionsController = new (require '../src/Controllers/ExhibitionsController')()

      it 'moment().format() is called once', ->
        ExhibitionsController.getUpcomingExhibitions items
        expect(formatSpy.calledOnce).to.be.true

      it 'moment().format() contains expected args', ->
        ExhibitionsController.getUpcomingExhibitions items
        expect(formatSpy.args[0][0]).to.deep.equal(expectedArgs)

      it 'returns an array of 1 if current date is within range', ->
        expect(ExhibitionsController.getUpcomingExhibitions items)
          .to.be.lengthOf(1)

      it 'returned array contains expected item', ->
        expect(ExhibitionsController.getUpcomingExhibitions items)
          .to.deep.equal(items)

    describe 'Returns back no valid exhibitions', ->
      beforeEach ->
        currentDate = '2016-12-19'
        formatSpy = sinon.spy(-> currentDate )
        momentSpy = sinon.spy(-> {
          format: formatSpy
        })
        mockery.registerMock('moment', momentSpy)
        ExhibitionsController = new (require '../src/Controllers/ExhibitionsController')()

      it 'moment().format() is called once', ->
        ExhibitionsController.getUpcomingExhibitions items
        expect(formatSpy.calledOnce).to.be.true

      it 'moment().format() contains expected args', ->
        ExhibitionsController.getUpcomingExhibitions items
        expect(formatSpy.args[0][0]).to.deep.equal(expectedArgs)

      it 'returns an array of 0 if current date is within range', ->
        expect(ExhibitionsController.getUpcomingExhibitions items)
          .to.be.lengthOf(0)

  after ->
    mockery.deregisterAll()
