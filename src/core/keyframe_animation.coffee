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
    keyframe = @keyframes.shift()
    target = keyframe.target()
    if target is null
      console.warn("The animation target '#{target()}' is not existing.")
      return
    properties = keyframe.properties()
    duration = keyframe.duration()
    properties['transition-duration'] = duration
    @css.addRule(target, properties)

    return unless @hasNextKeyframe()
    next_key = @keyframes[0]
    if next_key.timing() == 'with'
      @nextKeyframe()
    return 0
