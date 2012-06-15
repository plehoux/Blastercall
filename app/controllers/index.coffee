fs = require 'fs'
global.controllers = []

# Load all controllers
fs.readdirSync(__dirname).forEach (file) ->
  require "#{__dirname}/#{file}"
  controllerName = file.split('.')[0].classify
  controller = global[controllerName]
  if controller?
    global.controllers.push controller
