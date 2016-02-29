#
# Dissolve page effect
# Optional arguments
# - direction ..... Direction of movement
#     right  ... Left to Right
#     left   ... Right to Left
#     up ... Top to Bottom
#     down ... Bottom to Top
#
Libretto.registerPageEffect 'dissolve', ->
  before: (prevStyle, nextStyle, duration, options) ->
    nextStyle.opacity = "0"

  exec: (prevStyle, nextStyle, duration, options) ->
      nextStyle.transitionDuration = duration
      nextStyle.opacity = "1"

#
#
# MoveIn page Effect
# Optional arguments
# - direction ..... Direction of movement
#     right  ... Left to Right
#     left   ... Right to Left
#     up ... Top to Bottom
#     down ... Bottom to Top
#
Libretto.registerPageEffect 'move-in', ->

  before: (prevStyle, nextStyle, duration, options) ->
    origin = ({
      left  : ["100%", "0%"]
      right : ["-100%", "0%"]
      up    : ["0%", "100%"]
      down  : ["0%", "-100%"]
    })[options.direction]

    if origin is null
      if options.direction isnt null
        console.warn "Invalid value of direction: #{options.direction}"
      origin = ["100%", "0%"]
    nextStyle.left = origin[0]
    nextStyle.top = origin[1]

  exec: (prevStyle, nextStyle, duration, options) ->
    duration = '1s' if duration is null
    nextStyle.transitionDuration = duration
    nextStyle.left = "0%"
    nextStyle.top = "0%"

#
# Pushing page effect
# Optional arguments
# - direction ..... Direction of movement
#     right   ... Left to Right
#     left    ... Right to Left
#     up      ... Top to Bottom
#     down    ... Bottom to Top
#
Libretto.registerPageEffect 'push', ->

  before: (prevStyle, nextStyle, duration, options) ->
    posPrefix = {
      left  : ["0%", "0%", "100%", "0%", "-100%", "0%", "0%", "0%"]
      right : ["0%", "0%", "-100%", "0%", "100%", "0%", "0%", "0%"]
      up    : ["0%", "0%", "0%", "100%", "0%", "-100%", "0%", "0%"]
      down  : ["0%", "0%", "0%", "-100%", "0%", "100%", "0%", "0%"]
    }
    @pos = posPrefix[options.direction]
    if @pos is undefined
      if options.direction isnt undefined
        console.warn "Invalid value of direction: #{options.direction}"
      @pos = posPrefix["left"]
    prevStyle.left = @pos[0]
    prevStyle.top= @pos[1]
    nextStyle.left = @pos[2]
    nextStyle.top= @pos[3]

  exec: (prevStyle, nextStyle, duration, options) ->
    duration = '1s' if duration is null
    prevStyle.transitionDuration = duration
    prevStyle.left = @pos[4]
    prevStyle.top = @pos[5]
    nextStyle.transitionDuration = duration
    nextStyle.left = @pos[6]
    nextStyle.top = @pos[7]

#
# Slide-in Page Effect
# Optional arguments
# - direction ..... Direction of zooming
#     up
#     down
#     in
#     out
#
Libretto.registerPageEffect 'scale', ->

  before: (prevStyle, nextStyle, duration, options) ->
    direction = options.direction
    @targetNext = true   # A target of the animation is next slide when true
    @zoomin = true       # Zooming is zoom-in when true

    switch direction
      when "up"
        @targetNext = true
        @zoomin = true
      when "in"
        @targetNext = true
        @zoomin = false
      when "out"
        @targetNext = false
        @zoomin = true
      when "down"
        @targetNext = false
        @zoomin = false
      else
        if direction isnt null
          console.warn "Invalid value of direction: #{direction}"


    if @targetNext
      prevStyle.zIndex = "0"
      nextStyle.zIndex = "1"
      nextStyle.opacity = "0"
      if @zoomin
        nextStyle.transform = "scale(0.2,0.2)"
        nextStyle.mozTransform = "scale(0.2,0.2)"
        nextStyle.webkitTransform = "scale(0.2,0.2)"
      else
        nextStyle.transform = "scale(3.0,3.0)"
        nextStyle.mozTransform = "scale(3.0,3.0)"
        nextStyle.webkitTransform = "scale(3.0,3.0)"
    else # if next slide will animate
      prevStyle.zIndex = "1"
      nextStyle.zIndex = "0"
      prevStyle.opacity = "1"
      nextStyle.transform = "scale(1,1)"
      nextStyle.mozTransform = "scale(1,1)"
      nextStyle.webkitTransform = "scale(1,1)"
  
  exec: (prevStyle, nextStyle, duration, options) ->
    duration = '1s' if duration is null
    if @targetNext
      nextStyle.transitionDuration = duration
      nextStyle.opacity = "1"
      nextStyle.transform = "scale(1.0,1.0)"
      nextStyle.mozTransform = "scale(1.0,1.0)"
      nextStyle.webkitTransform = "scale(1.0,1.0)"
    else
      prevStyle.transitionDuration = duration
      prevStyle.opacity = "0"
      if @zoomin
        prevStyle.transform = "scale(3,3)"
        prevStyle.mozTransform = "scale(3,3)"
        prevStyle.webkitTransform = "scale(3,3)"
      else
        prevStyle.transform = "scale(0.2,0.2)"
        prevStyle.mozTransform = "scale(0.2,0.2)"
        prevStyle.webkitTransform = "scale(0.2,0.2)"

