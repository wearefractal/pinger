pinger = require '../'
should = require 'should'
ben = require 'ben'
require 'mocha'

describe 'pinger', ->
  describe 'ping()', ->
    it 'should return true for google.com', (done) ->
      pinger.ping 'google.com', (up) ->
        should.exist up
        up.should.equal true
        done()

    it 'should handle many pings to google.com', (done) ->
      count = 5
      donzo = (up) ->
        should.exist up
        up.should.equal true
        done() if --count is 0
      pinger.ping 'google.com', donzo
      pinger.ping 'google.com', donzo
      pinger.ping 'google.com', donzo
      pinger.ping 'google.com', donzo
      pinger.ping 'google.com', donzo

    it 'should return false for pingusdingus1337.com', (done) ->
      pinger.ping 'pingusdingus1337.com', (up) ->
        should.exist up
        up.should.equal false
        done()

  describe 'benchmark', ->
    it 'should spin mad bau5 d0g', (done) ->
      @timeout 900000000
      ping = require 'ping'
      ours = (done) -> pinger.ping 'google.com', done
      theirs = (done) -> ping.sys.probe 'google.com', done

      ben.async 50, ours, (ms) ->
        console.log "pinger: #{ms}"
        ben.async 50, theirs, (ms) ->
          console.log "node-ping: #{ms}"
          done()