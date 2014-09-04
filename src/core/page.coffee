#
# Scena.Page class
# 
# The Page class provides the page of the slides.  The Page object is created
# from <section> node in HTML.  The css of the page is modified with show(),
# hide(), and neutralStyle() methods.
#

class window.Scena.Page
  #
  # Returns the number of the pages in the document.
  #
  @count: ->
    document.body.getElementsByTagName('section').length
  #
  # Returns a Page object of specified index
  #
  @pageAt: (index) ->
    element = document.body.getElementsByTagName('section')[index]
    obj = new Scena.Page
    obj.element = element
    return obj

  #
  # Returns the effect name of the page animation
  #
  animationEffect : () ->
    return null if @element is null
    @element.getAttribute('effect')

  #
  # Returns the duration of the page animation
  #
  animationDuration: () ->
    return null if @element is null
    @element.getAttribute('duration')

  #
  # Returns all attributes.
  #
  animationOptions : ->
    return null if @element is null
    obj = {}
    for attr in @element.attributes
      if attr.nodeName != "style" && attr.nodeName != "effect" &&
         attr.nodeName != "duration"
        obj[attr.nodeName] = attr.value
    return obj

  #
  # Create animation object
  #
  createAnimation: ->
    return null if @element is null
    animeEle = @element.getElementsByTagName('animation')[0]
    return null if (animeEle is undefined or animeEle is null)
    return new Scena.KeyframeAnimation(animeEle)

