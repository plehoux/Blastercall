class Player extends GameObject

  constructor: ->
    super()

    @keysPressed =
      left: false
      up: false
      right: false
      down: false

    $(document).on 'keydown', this.onKeyDown
    $(document).on 'keyup', this.onKeyUp

  # DOM management
  createElem: ->
    super('player')

  # Keyboard management
  onKeyDown: (e) =>
    return if [37, 38, 39, 40].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = true
      when 38 then @keysPressed.up = true
      when 39 then @keysPressed.right = true
      when 40 then @keysPressed.down = true

  onKeyUp: (e) =>
    return if [37, 38, 39, 40].indexOf(e.keyCode) < 0
    switch e.keyCode
      when 37 then @keysPressed.left = false
      when 38 then @keysPressed.up = false
      when 39 then @keysPressed.right = false
      when 40 then @keysPressed.down = false

  # Movement management
  tick: ->
    this.turn(-1) if @keysPressed.left
    this.turn(1) if @keysPressed.right
    this.move(-1) if @keysPressed.up

    this.setTransform()

  turn: (increment) ->
    @transform.rotation += increment * 3

  move: (increment) ->
    console.log @transform.rotation
    angle = @transform.rotation - 90
    vectorX = Math.cos(angle * Math.PI/180)
    vectorY = Math.sin(angle * Math.PI/180)

    @transform.x += vectorX
    @transform.y += vectorY

window.Player = Player
