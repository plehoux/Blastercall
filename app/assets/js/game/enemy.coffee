class Enemy
  @BOMB_RADIUS = 50

  constructor: (from) ->
    @from = from || "666-666-6666"
    @bomb = null

  addBomb: (@coord) ->
    countdown = 3
    @bomb = $("<div class='bomb' data-from='#{@from.slice(-4)}'></div>")
    span = $("<span>#{countdown}</span>")

    @bomb.append span
    @bomb.css
      left: @coord.x
      top: @coord.y

    @timer = setInterval =>
      if countdown <= 0
        clearInterval @timer
        this.explode()
      else
        countdown--
        span.html countdown
    , 1000

  explode: =>
    return unless @bomb
    clearInterval @timer
    snd = new Audio "wave/explosion.wav"
    snd.play()
    @bomb.addClass 'explode'
    @bomb.trigger 'explodes', [@coord]

  checkChainReaction: (coord) ->
    return if coord.x == @coord.x
    x = @coord.x
    y = @coord.y
    cx = coord.x
    cy = coord.y

    distance = Math.sqrt((x-cx)*(x-cx)+(y-cy)*(y-cy))
    if distance < 250
      setTimeout this.explode, 250

  defuse: ->
    return unless @bomb && !@bomb.hasClass('defuse')
    clearInterval @timer
    snd = new Audio "wave/defuse2.wav"
    snd.play()
    @bomb.addClass 'defuse'


window.Enemy = Enemy