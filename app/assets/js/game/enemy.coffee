class Enemy extends GameObject
  constructor:(from)->
    @from        = from || "666-666-6666"
    super()
    @moveTo      = null
    @transform.x = Math.floor(Math.random() * 1280) + 1
    @transform.y = Math.floor(Math.random() * 768 ) + 1

  # DOM management
  createElem: ->
    super('enemy',@from.slice(-4))

  tick: ->
    super()

window.Enemy = Enemy