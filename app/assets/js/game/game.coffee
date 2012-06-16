window.enemies = {}

class Game
  constructor: ->
    @game   = $('#game')
    @status = $('#status')

    $(document).one 'keypress', (event) =>
      @play() if event.which == 32

    @status.children('small').click (event) =>
      @play()
      event.preventDefault()

    @state   = 'TITLE_SCREEN'
    @enemies = {}
    @bombs = {}
    @listen()
    @addPlayer()
    @tick()
    @generateBullets()

    [1..2].forEach (i) =>
      setTimeout =>
        @addEnemy i, "#{i}-418-1234"
        @addBomb i, 2
        # @addBomb i, this.random(1, 9)
      , 1000 * (i*2)

  random: (min, max) ->
    min + (Math.random() * (max - min))

  play:->
    @hideStatus()

  hideStatus:->
    @status.removeClass('show')

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    @enemies[id] = new Enemy(from)
    # console.log "#{from} just connected!"

  deleteEnemy: (id)->
    @enemies[id].elem.remove()
    delete @enemies[id]
    # console.log "#{@enemies[id].from} just disconnected!"

  addBomb: (id, zone)->
    enemy = @enemies[id]
    return if enemy.bomb

    coord = Grid.getCoordinate(zone)
    enemy.addBomb(coord)
    @game.append enemy.bomb
    enemy.bomb.on 'explodes', this.onBombExpldoes

  onBombExpldoes: (e, coord) =>


  deleteBomb: (id) ->
    enemy = @enemies[id]
    return unless enemy.bomb

    enemy.bomb.remove()
    enemy.bomb = null
    # console.log "#{@enemies[id].from} bomb removed!"

  tick: =>
    for id, enemy of @enemies
      continue unless enemy.bomb
      offset = enemy.bomb.offset()

      left = offset.left + Enemy.BOMB_RADIUS / 2
      top = offset.top + Enemy.BOMB_RADIUS / 2

      if @player.collision(left, top)
        enemy.defuse()

    @player.tick()
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
          @addBomb(params.CallSid, params.Digits)

  generateBullets: ->

new Game
