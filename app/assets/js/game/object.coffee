class GameObject
  constructor:->
    @transform =
      x: 0
      y: 0
      rotation: 0
    @createElem()

  # DOM management
  createElem: (type)->
    @elem = $("<div class='#{type}'></div>")

window.GameObject = GameObject