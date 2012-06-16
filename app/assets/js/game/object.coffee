class GameObject
  constructor:->
    @transform =
      x: 0
      y: 0
      rotation: 0
    @createElem()

  # DOM management
  createElem: (type,content)->
    @elem = $("<div class='#{type}'>#{if content? then content else ''}</div>")

  tick:->
    this.setTransform()

  setTransform: ->
    @elem.css '-webkit-transform': "translate3d(#{@transform.x}px, #{@transform.y}px, 0) rotate(#{@transform.rotation}deg)"


window.GameObject = GameObject