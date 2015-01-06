class window.Libretto.Animation

  #
  #
  #
  constructor: (@page) ->
    @keyframes = []
    @index = 0
    animationNodes = @page.element.getElementsByTagName('animation')
    for node in animationNodes
      keyframeNodes = node.getElementsByTagName('keyframe')
      for k in keyframeNodes
        @keyframes.push(new Libretto.Keyframe(k))
    @css = Libretto.Css.findOrCreate("animation-#{@page.indexOf()}")

  #
  #
  #
  reset: ->
    @css.clearRules()
    @index = 0

  #
  #
  #
  hasNextKeyframe: ->
    @index < @keyframes.length

  #
  #
  #
  nextKeyframe : ->
    return null unless @hasNextKeyframe()
    return @execKeyframe(0)

  execKeyframe : (afterTime) ->
    keyframe = @keyframes[@index]
    ++@index
    target = keyframe.target()
    if target is null
      console.warn("The animation target is not specified.")
      return null
    properties = keyframe.properties()
    duration = keyframe.duration()
    if keyframe.delay() == null
      delay = afterTime + 'ms'
    else
      delay = (Animation.timeToMillisecond(keyframe.delay()) + afterTime) + 'ms'
    properties['transition-duration'] = duration
    properties['transition-delay'] = delay
    targetStr = "section:nth-of-type(#{@page.indexOf() + 1}) #{target}"
    @css.addRule(targetStr, properties)

    return unless @hasNextKeyframe()
    next_key = @keyframes[@index]
    if next_key.timing() == 'with'
      @execKeyframe(afterTime)
    else if next_key.timing() == 'after'
      afterTime += Animation.timeToMillisecond(duration) if duration isnt null
      @execKeyframe(afterTime)
    return 0

  #
  # Converts time descrived as string to millisecond
  # timeToMs("200ms")    // return 200
  # timeToMs("5s")       // return 5000
  # timeToMs("1.4s")     // return 1400
  #
  @timeToMillisecond: (time) ->
    return null if time.length == 0
    msec1 = +(time.split("ms")[0])
    msec2 = time.split("s")[0] * 1000
    num = msec1 || msec2
    return null if isNaN(num)
    return num
