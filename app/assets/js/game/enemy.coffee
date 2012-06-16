class Enemy extends GameObject
  @RADIUS = 51

  constructor:(from)->
    @from = from || "666-666-6666"
    @hasMoved = false
    super()

  # DOM management
  createElem: ->
    super('enemy', @from.slice(-4))

  moveTo: (coord) ->
    @transform.x = coord.x
    @transform.y = coord.y

  tick: ->
    super()

window.Enemy = Enemy