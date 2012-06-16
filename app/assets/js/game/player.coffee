class Player extends GameObject
  @DETECTION_POINTS_NBR = [1..11]
  constructor: ->
    super()

    @window = $(window)
    @speed = 0
    @keysPressed =
      left: false
      up: false
      right: false
      down: false

    $(document).on 'keydown', this.onKeyDown
    $(document).on 'keyup', this.onKeyUp

  # DOM management
  createElem: ->
    super('player','<div class="arrow"></div>')
    console.log Player.DETECTION_POINTS_NBR
    @elem.append("<span class='point_#{i}'></span>") for i in Player.DETECTION_POINTS_NBR

  # Keyboard management
  onKeyDown: (e) =>
    return if [37, 38, 39].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = true
      when 38 then @keysPressed.up = true
      when 39 then @keysPressed.right = true

  onKeyUp: (e) =>
    return if [37, 38, 39].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = false
      when 38 then @keysPressed.up = false
      when 39 then @keysPressed.right = false

  # Movement management
  tick: ->
    this.turn(-1) if @keysPressed.left
    this.turn(1) if @keysPressed.right
    this.speedUp() if @keysPressed.up
    this.speedDown() if !@keysPressed.up
    this.move()
    super()

  turn: (increment) ->
    @transform.rotation += increment * 8

  speedUp: ->
    if @speed >= 15
      @speed = 15
      return

    @speed += .2

  speedDown: ->
    if @speed <=0
      @speed = 0
      return

    @speed -= .1

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

window.Player = Player
