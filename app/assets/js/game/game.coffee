window.enemies = {}

class Game
  constructor: ->
    @game = $('#game')
    @enemies = {}
    @listen()
    @addPlayer()
    @tick()
    @addEnemy('asd','934-7234')

    @addEnemy '123', '418-418-4184'
    @moveEnemy '123', 3

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    console.log "#{from} just connected!"
    @enemies[id] = new Enemy(from)
    @game.append @enemies[id].elem

  deleteEnemy: (id)->
    console.log "#{@enemies[id].from} just disconnected!"
    @enemies[id].elem.remove()
    delete @enemies[id]

  moveEnemy: (id, zone)->
    @enemies[id].moveTo = Grid.getCoordinate(zone)
    console.log "#{@enemies[id].from} move to #{@enemies[id].moveTo}!"

  tick: =>
    @player.tick()
    enemy.tick() for id,enemy of @enemies
    requestAnimationFrame(@tick)

  listen:->
    socket = io.connect "http://#{window.location.host}"
    socket.on 'action', (data) =>
      action  = data.action
      params  = data.params
      switch action
        when 'connect'
          @addEnemy(params.CallSid,params.From)
        when 'disconnect'
          @deleteEnemy(params.CallSid)
        when 'move'
          @moveEnemy(params.CallSid,params.Digits)

new Game
