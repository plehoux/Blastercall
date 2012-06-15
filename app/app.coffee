# Modules
express = require 'express'
app = global.app = module.exports = express.createServer()

# Boot setup
require "#{__dirname}/../config/boot"

# Socket.io
io = require('socket.io').listen app
io.sockets.on 'connection', (socket) ->
  global.socket = socket

# Configuration
app.configure ->
  app.use express.static "#{__dirname}/../public"
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'ejs'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require('connect-assets')(src: "#{__dirname}/assets")
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'production', ->
  app.use express.errorHandler()

# Routes
require "#{__dirname}/routes"

# Server
port = process.env.PORT || 3000
if process.argv.indexOf('-p') >= 0
  port = process.argv[process.argv.indexOf('-p') + 1]

app.listen port
if app.settings.env == 'development'
  console.log "Express server listening on port #{port} in #{app.settings.env} mode"
