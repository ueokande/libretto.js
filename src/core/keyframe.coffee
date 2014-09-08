#
# Scena.Keyframe class
# 
# The Scena.Keyframe class provides the keyframe of the animation.
# The animation mechanism is very simple, the style (css) of the element in
# HTML will be overwritten when the keyframe is fired.  To use it, create a
# Scena.Keyframe from the HTML element object which described as <keyframe>
# tag in HTML.  The <keyframe> tag is distinctive specification in Scena.js.
# The keyframe will be fired with start() method.
#

class window.Scena.Keyframe
  #
  # Constructs a Keyframe object with the given element which is a element
  # contained in <keyframe>.
  #
  constructor: (@element) ->
    @element = null if @element is undefined

  #
  # Returns the target of the keyframe.
  #
  target: ->
    return null if @element is null
    return @element.getAttribute("target")

  #
  # Returns the duration of the animation as text.  Return null If the
  # duration is note speficied.
  #
  duration : ->
    return null if @element is null
    return @element.getAttribute("duration")

  properties : ->
    return null if @element is null
    obj = {}
    attrs = @element.attributes
    for attr in @element.attributes
      if attr.nodeName != "target" && attr.nodeName != "duration"
        obj[attr.nodeName] = attr.value
    return obj

  timing : ->
    return null if @element is null
    return @element.getAttribute("timing")
