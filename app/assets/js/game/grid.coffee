class Grid

  constructor: ->
    @cells = $('.numpad li')

  getCoordinate: (zone) ->
    $zone = @cells.eq(zone - 1)
    position = $zone.position()
    bounds =
      top: position.top
      right: position.left + $zone.width()
      bottom: position.top + $zone.height()
      left: position.left

    randX = this.random(bounds.left, bounds.right)
    randY = this.random(bounds.top, bounds.bottom)

  random: (min, max) ->
    min + (Math.random() * (max - min))


window.Grid = new Grid
