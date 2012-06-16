class Enemy extends GameObject
  @RADIUS = 51

  constructor:(from)->
    @from = from || "666-666-6666"
    @hasMoved = false
    super()

  # DOM management
  createElem: ->
    super('enemy', "<span>#{@from.slice(-4)}</span>")

  moveTo: (coord) ->
    @elem.addClass 'spawning'

    setTimeout =>
      @elem.removeClass 'spawning'
    , 1000

    @transform.x = coord.x
    @transform.y = coord.y

  tick: ->
    super()

  canCollide: ->
    !@elem.hasClass 'spawning'

window.Enemy = Enemy