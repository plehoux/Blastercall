window.enemies = {}

class Game
  constructor: ->
    @game   = $('#game')
    @status = $('#status')
    @ennemiesLength = 0

    $(document).keypress((event)=>
        @play() if event.which == 32
      )
    $('#startgame').click (event)=>
        @play()
        event.preventDefault()

    @changeGameState 'TITLE_SCREEN'
    @enemies = {}
    @bombs = {}
    @listen()
    @addPlayer()
    @tick()
    @generateBullets()

    [1..20].forEach (i) =>
      setTimeout =>
        @addEnemy i, "#{i}-418-1234"
        @addBomb i, this.random(1, 9)
      , 1000 * i

  random: (min, max) ->
    min + (Math.random() * (max - min))

  changeGameState:(newState)->
    @game.removeClass(@state.toLowerCase()) if @state
    @state = newState
    @game.addClass(newState.toLowerCase())

  play:->
    unless @state is "GAME_ON"
      $("#startgame").hide()
      $("#phoneNumber").show()
      @changeGameState "GAME_ON"

  gameOver:->
    @changeGameState "GAME_OVER"
    @status.children('h1.title').hide()
    @status.children('strong.tel').hide()
    @status.children('h1.score').html("score: #{@player.points}").show()
    @status.children('strong.gameover').html("GAME OVER").css('display','block')
    $("#startgame").show()
    $("#phoneNumber").hide()
    @player.life  = Player.NBR_OF_LIFE
    @player.score = 0
    $('.lost').removeClass('lost')
    @score.html "score: 0"

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    @enemies[id] = new Enemy(from)
    $('#nb_players').html(@ennemiesLength++)
    # console.log "#{from} just connected!"

  deleteEnemy: (id)->
    @enemies[id].elem.remove()
    delete @enemies[id]
    $('#nb_players').html(@ennemiesLength--)
    # console.log "#{@enemies[id].from} just disconnected!"

  addBomb: (id, zone)->
    enemy = @enemies[id]
    return if enemy.bomb

    coord = Grid.getCoordinate(zone)
    enemy.addBomb(coord)
    @game.append enemy.bomb
    enemy.bomb.on 'explodes', (e, coord) =>
      this.deleteBomb(id)
      this.onBombExplodes(coord)

  onBombExplodes: (coord) ->
    for id, enemy of @enemies
      continue unless enemy.bomb
      enemy.checkChainReaction coord
    if @player.collision(coord.x, coord.y, 250)
      @player.kill()
      # @player.elem.addClass 'dead'

  deleteBomb: (id) ->
    enemy = @enemies[id]
    return unless enemy.bomb

    setTimeout ->
      return unless enemy.bomb
      enemy.bomb.remove()
      enemy.bomb = null
    , 1000

  tick: =>
    for id, enemy of @enemies
      continue unless enemy.bomb
      offset = enemy.bomb.offset()
      left = offset.left + Enemy.BOMB_RADIUS / 2
      top = offset.top + Enemy.BOMB_RADIUS / 2

      if @player.collision(left, top) and !enemy.bomb.hasClass('defuse')
        enemy.defuse() 
        @player.points++
        this.deleteBomb(id)

    @player.tick()
    @gameOver() if @state is "GAME_ON" and @player.life <= 0
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
