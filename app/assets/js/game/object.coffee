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

  setTransform: ->
    @elem.css '-webkit-transform': "translate3d(#{@transform.x}px, #{@transform.y}px, 0) rotate(#{@transform.rotation}deg)"


window.GameObject = GameObject