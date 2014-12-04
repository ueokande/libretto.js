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
    @sectionNodes().length
  #
  # Returns a Page object of specified index
  #
  @pageAt: (index) ->
    element = @sectionNodes()[index]
    return null if element is undefined
    obj = new Scena.Page
    obj.element = element
    return obj

  @sectionNodes = ->
    children = document.body.children
    nodes = []
    for node in children
      nodes.push(node) if node.tagName.match(/section/i)
    return nodes


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
  # Returns index of the pages
  #
  indexOf: ->
    sections = Scena.Page.sectionNodes()
    return sections.indexOf(@element)

  #
  # Create animation object
  #
  animation: ->
    return null if @element is null
    animeEle = @element.getElementsByTagName('animation')[0]
    return null if (animeEle is undefined or animeEle is null)
    return new Scena.Animation(animeEle, "animation-#{@indexOf()}")
