# Import Box2D classes
b2Vec2 = Box2D.Common.Math.b2Vec2
b2AABB = Box2D.Collision.b2AABB
{b2BodyDef, b2Body, b2FixtureDef, b2Fixture, b2World, b2DebugDraw} = Box2D.Dynamics
{b2RevoluteJoint, b2RevoluteJointDef} = Box2D.Dynamics.Joints
{b2MassData, b2PolygonShape, b2CircleShape} = Box2D.Collision.Shapes

# Game class
class Game

  constructor: ->
    @canvas = document.getElementsByTagName('canvas')[0]
    @ctx = @canvas.getContext('2d')

    @timestep = 1/30
    @iterations = 10
    @pixelsPerMeter = 30

    this.makeWorld()
    this.setDebugDraw()
    this.addFloor()
    this.addPaddle()
    this.addPlayer()
    # this.addCircles()

    this.update()

  # World management
  makeWorld: ->
    gravity = new b2Vec2 0.0, 10.0
    doSleep = true

    @world = new b2World gravity, doSleep
    @world.SetWarmStarting true

  # Debug management
  setDebugDraw: ->
    debugDraw = new b2DebugDraw
    debugDraw.SetSprite @ctx
    debugDraw.SetDrawScale 30
    debugDraw.SetFillAlpha 0.3
    debugDraw.SetLineThickness 1.0
    debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
    @world.SetDebugDraw debugDraw

  # Walls management
  addFloor: ->
    size =
      w: this.size @canvas.width / 2
      h: this.size 100

    position =
      x: this.size @canvas.width / 2
      y: this.size @canvas.height + 95

    wall = new b2PolygonShape
    wall.SetAsBox size.w, size.h

    wallBd = new b2BodyDef
    wallBd.position.Set(position.x, position.y)
    wallB = @world.CreateBody(wallBd)
    wallB.CreateFixture2(wall)

  # Paddle management
  addPaddle: ->
    # Pivot
    pivot = new b2CircleShape(0.5)
    pivot.density = 0
    pivotBd = new b2BodyDef
    pivotBd.position.Set(8.5,6.5);
    pivotB = @world.CreateBody(pivotBd)
    pivotB.type = b2Body.b2_dynamicBody
    pivotB.CreateFixture2(pivot)

    # Paddle
    paddle = new b2PolygonShape
    paddle.SetAsBox(4,0.5)
    paddle.density = 0.01
    paddle.friction = 1
    paddle.restitution = 0.1
    paddleBd = new b2BodyDef
    paddleBd.position.Set(6.5,6.5);
    paddleB = @world.CreateBody(paddleBd)
    paddleB.type = b2Body.b2_dynamicBody
    paddleB.CreateFixture2(paddle)

    # Revolute Joint
    joint = new b2RevoluteJointDef()
    joint.Initialize(pivotB, paddleB, pivotB.GetWorldCenter())
    @world.CreateJoint(joint)

    # size =
    #   w: this.size 450
    #   h: this.size 10
    #
    # position =
    #   x: this.size @canvas.width / 2
    #   y: this.size @canvas.height - 117
    #
    # center = new b2Vec2 0, 0
    # paddle = new b2PolygonShape
    # paddle.SetAsOrientedBox size.w, size.h, center, this.size 0
    #
    # paddleBd = new b2BodyDef
    # paddleBd.position.Set(position.x, position.y)
    # paddleB = @world.CreateBody(paddleBd)
    # paddleB.CreateFixture2(paddle)

  # Player management
  addPlayer: ->
    @playerBd = new b2BodyDef
    @playerBd.type = b2Body.b2_dynamicBody

    radius = this.size 50
    circDef = new b2CircleShape radius

    player = new b2FixtureDef
    player.shape = circDef
    player.density = 1
    player.friction = 0.3
    player.restitution = 0.1

    position =
      x: this.size @canvas.width / 2
      y: this.size @canvas.height - 50

    @playerBd.position.Set(position.x, position.y)
    playerB = @world.CreateBody(@playerBd)
    playerB.CreateFixture(player)

    # console.log $(document)
    $(document).on 'keydown', (e) =>
      newPosition =
        x: position.x += 1
        y: position.y += 1

      # console.log @playerBd
      @playerBd.linearVelocity.angle = 20
      console.log @playerBd

  # Circles management
  addCircles: ->
    for i in [1..5]
      bodyDefC = new b2BodyDef
      bodyDefC.type = b2Body.b2_dynamicBody

      radius = this.size Math.random() * 5 + 10
      circDef = new b2CircleShape radius

      fd = new b2FixtureDef
      fd.shape = circDef
      fd.density = 1
      fd.friction = 0.9
      fd.restitution = 0.1

      bodyDefC.position.Set((Math.random() * 400 + 120) / @pixelsPerMeter, (Math.random() * 150 + 50) / @pixelsPerMeter)
      bodyDefC.angle = Math.random() * Math.PI
      body = @world.CreateBody(bodyDefC)
      body.CreateFixture(fd)

  size: (size) ->
    size / @pixelsPerMeter

  # Update
  update: =>
    @world.Step @timestep, @iterations, @iterations
    @world.ClearForces()

    # Render
    @world.DrawDebugData()

    # Tick
    requestAnimationFrame(this.update)


new Game
