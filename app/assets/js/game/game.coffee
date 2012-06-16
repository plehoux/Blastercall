window.enemies = {}

class Game
  constructor: ->
    @game = $('#game')
    @enemies = {}
    @listen()
    @addPlayer()
    @tick()

    @addEnemy '123', '418-418-4184'
    @moveEnemy '123', 3

    # setTimeout =>
      # @moveEnemy '123', 7
    # , 6000

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    console.log "#{from} just connected!"
    @enemies[id] = new Enemy(from)

  deleteEnemy: (id)->
    console.log "#{@enemies[id].from} just disconnected!"
    @enemies[id].elem.remove()
    delete @enemies[id]

  moveEnemy: (id, zone)->
    enemy = @enemies[id]
    coord = Grid.getCoordinate(zone)

    if !enemy.hasMoved
      enemy.hasMoved = true
      @game.append enemy.elem

    enemy.moveTo(coord)
    console.log "#{enemy.from} move to (#{coord.x}, #{coord.y})!"

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
