chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'walters-museum-api', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/walters-museum-api')(@robot)

  it 'registers to exhibitions listener', ->
    expect(@robot.respond).to.have.been.calledWith(/(recent|latest) exhibitions?/)

  it 'registers to collections listener', ->
    expect(@robot.respond).to.have.been.calledWith(/collections/)
