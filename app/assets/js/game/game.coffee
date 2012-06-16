class Game

  constructor: ->
    @game = $('#game')

    this.addPlayer()
    this.tick()

  # Player management
  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  # Render management
  tick: =>
    @player.tick()
    requestAnimationFrame(this.tick)


new Game
