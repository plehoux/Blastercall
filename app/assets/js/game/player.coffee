class Player extends GameObject
  @DETECTION_POINTS_NBR = [1..11]
  @NBR_OF_LIFE          = 3
  constructor: ->
    super()
    @life        = Player.NBR_OF_LIFE
    @points      = 0
    @window      = $(window)
    @speed       = 0
    @keysPressed =
      left: false
      right: false
    @transform.x = (@window.width() / 4) - 50
    @transform.y = (@window.height() / 4) - 50
    @transform.rotation = 45

    $(document).on 'keydown', this.onKeyDown
    $(document).on 'keyup', this.onKeyUp

  # DOM management
  createElem: ->
    super('player','<div class="arrow"></div>')
    @elem.append("<span class='point_#{i}'></span>") for i in Player.DETECTION_POINTS_NBR

  # Keyboard management
  onKeyDown: (e) =>
    return if [37, 39].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = true
      when 39 then @keysPressed.right = true

  onKeyUp: (e) =>
    return if [37, 39].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = false
      when 39 then @keysPressed.right = false

  # Movement management
  tick: ->
    this.turn(-1) if @keysPressed.left
    this.turn(1) if @keysPressed.right
    this.speedUp()
    this.move()
    super()

  turn: (increment) ->
    @transform.rotation += increment * 8

  speedUp: ->
    if @speed >= 12
      @speed = 12
      return

    @speed += .2

  move: (increment) ->
    return if @speed == 0
    angle = @transform.rotation
    vectorX = Math.cos(angle * Math.PI/180) * @speed
    vectorY = Math.sin(angle * Math.PI/180) * @speed

    @transform.x += vectorX
    @transform.y += vectorY

    @transform.x = -20 if @transform.x > @window.width()
    @transform.x = @window.width() if @transform.x < -20
    @transform.y = -50 if @transform.y > @window.height()
    @transform.y = @window.height() if @transform.y < -50

  collision: (cx, cy, range=0) ->
    return false if @elem.hasClass 'dead'
    for i in Player.DETECTION_POINTS_NBR
      offset = @elem.children(".point_#{i}").offset()
      if offset?
        x = offset.left
        y = offset.top
        distance = Math.sqrt((x-cx)*(x-cx)+(y-cy)*(y-cy))
        collision = if range > 0 then (distance < 250) else (distance < Enemy.BOMB_RADIUS / 2)
      break if collision
    return collision

  kill: ->
    @life--
    $('#life li').not('.lost').last()?.addClass('lost')
    @elem.addClass 'dead'

    setTimeout =>
      @elem.removeClass 'dead'
    , 1500


window.Player = Player
