class window.Scena.KeyframeAnimation

  #
  #
  #
  constructor: (animationElement, styleName) ->
    @keyframes = []
    @css = null
    return if animationElement is null

    keyframeNodes = animationElement.getElementsByTagName('keyframe')
    for k in keyframeNodes
      @keyframes.push(new Scena.Keyframe(k))
    if styleName isnt undefined
      @css = new Scena.Css(styleName)
    else
      @css = new Scena.Css('animation')

  #
  #
  #
  finalize: ->
    return if @css is null
    @css.finalize()
    @css = null

  #
  #
  #
  hasNextKeyframe: ->
    return null if @css is null
    @keyframes.length > 0

  #
  #
  #
  nextKeyframe : ->
    return null if @css is null
    return null if @keyframes.length == 0
    return @execKeyframe(0)

  execKeyframe : (afterTime) ->
    keyframe = @keyframes.shift()
    target = keyframe.target()
    if target is null
      console.warn("The animation target '#{target()}' is not existing.")
      return
    properties = keyframe.properties()
    duration = keyframe.duration()
    delay = keyframe.delay()
    unless delay == null
      delay = (KeyframeAnimation.timeToMillisecond(delay) + afterTime) + 'ms'
    properties['transition-duration'] = duration
    properties['transition-delay'] = delay
    @css.addRule(target, properties)

    return unless @hasNextKeyframe()
    next_key = @keyframes[0]
    if next_key.timing() == 'with'
      @execKeyframe(finishTime)
    else if next_key.timing() == 'after'
      afterTime += KeyframeAnimation.timeToMillisecond(duration) if duration isnt null
      afterTime += KeyframeAnimation.timeToMillisecond(delay) if delay isnt null
      @execKeyframe(finishTime)
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
