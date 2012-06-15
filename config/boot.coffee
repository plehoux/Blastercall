global.helpers = require "#{__dirname}/../app/helpers"

EventEmitter = require('events').EventEmitter
global.dispatcher = new EventEmitter

require "#{__dirname}/../app/controllers"
