class Enemy extends GameObject
  constructor:(from)->
    super()
    @from        = from || "666-666-6666"
    @moveTo      = null
    @transform.x = Math.floor(Math.random() * 1280) + 1
    @transform.y = Math.floor(Math.random() * 768 ) + 1

  # DOM management
  createElem: ->
    super('enemy')

  tick: ->
    super()

window.Enemy = Enemy