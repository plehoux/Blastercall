window.enemies = {}

class Game
  constructor: ->
    @game   = $('#game')
    @status = $('#status')
    $(document).keypress((event)=>
        @play() if event.which == 32
      )
    $('#status').click (event)=>
        @play()
        event.preventDefault()
    @state   = 'TITLE_SCREEN'
    @enemies = {}
    @bombs = {}
    @listen()
    @addPlayer()
    @tick()
    @generateBullets()
    @addEnemy '123', '418-418-4184'

    setTimeout =>
      @addBomb '123', 3
    , 2000

  play:->
    unless @state is "GAME_ON"
      @state = "GAME_ON"
      @hideStatus()

  gameover:->
    @state = "GAME_OVER"
    @status.html """
      Gameover<br>
      <small>You made 999 points.</small>
    """
    @status.addClass('show')

  hideStatus:->
    @status.removeClass('show')

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    @enemies[id] = new Enemy(from)
    console.log "#{from} just connected!"

  deleteEnemy: (id)->
    @enemies[id].elem.remove()
    delete @enemies[id]
    console.log "#{@enemies[id].from} just disconnected!"

  addBomb: (id, zone)->
    enemy = @enemies[id]
    return if enemy.bomb

    coord = Grid.getCoordinate(zone)
    enemy.addBomb(coord)
    @game.append enemy.bomb

    console.log "#{enemy.from} added a bomb to (#{coord.x}, #{coord.y})!"

  deleteBomb: (id) ->
    enemy = @enemies[id]
    return unless enemy.bomb
    enemy.bomb.remove()
    enemy.bomb = null
    console.log "#{@enemies[id].from} bomb removed!"

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
