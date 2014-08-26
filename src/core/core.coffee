class window.Scena.Plugin
  constructor: (name) ->
    window.addEventListener("load", @initialize)

  initialize: ->

  core: ->
    window.Scena.core


class window.Scena.Core extends window.Scena.Plugin

  #
  # Initializes internal variables and HTML contents.
  #
  constructor: ->
    @currentAnimation = null
    @pages = null
    @currentIndex = null
    @pageAnimation = null
    @currentPageChangedListeners = []

    window.Scena.core = @
    super()

  getCurrentIndex: ->
    @currentIndex

  #
  # Initializes internal variables and HTML contents.
  #
  initialize: =>
    sections = document.body.getElementsByTagName("section")
    return if sections.length is 0
    @pages = []
    @pages.push(new Scena.Page(p)) for p in sections

  #
  # Skips to specified page without animation.
  #
  skipToPage: (index) ->
    return if @pages is null
    switchPage.call(@, index, false)

  #
  #
  #
  animateToPage: (index) ->
    return if @pages is null
    switchPage.call(@, index, true)

  #
  #
  #
  switchPage = (index, animationEnable) ->
    index = 0 if index < 0
    index = @pages.length - 1 if @pages.length - 1 < index
    return if index is @currentIndex

    prevIndex = if @currentIndex isnt null then @currentIndex else null
    nextIndex = index
    currentPage = @pages[index]
    @currentIndex = index
    @currentAnimation.finalize() if @currentAnimation isnt null
    @currentAnimation = currentPage.createAnimation()

    @pageAnimation.finalize() if @pageAnimation isnt null
    @pageAnimation = new Scena.PageAnimation(prevIndex, nextIndex, currentPage)
    @pageAnimation.switchPage(animationEnable)

    l() for l in @currentPageChangedListeners

  #
  # Animate the element of page to next.
  #
  nextStep: ->
    if @currentAnimation is null or !@currentAnimation.hasNextKeyframe()
      @animateToPage(@currentIndex + 1)
    else
      @currentAnimation.nextKeyframe()

  #
  # Skip to previous step of page.
  #
  prevStep: ->
    @skipToPrevPage()

  #
  # Skips to next page without animation.
  #
  skipToNextPage: ->
    @skipToPage(@currentIndex + 1)

  #
  # Skips to previous page without animation.
  #
  skipToPrevPage: ->
    @skipToPage(@currentIndex - 1)

  #
  # Skips to last page without animation.
  #
  skipToFirstPage: ->
    @skipToPage(0)

  #
  # Skips to last page without animation.
  #
  skipToLastPage: ->
    @skipToPage(@pages.length - 1)

  #
  #
  #
  addCurrentPageChangedListener: (listener) ->
    @currentPageChangedListeners.push(listener)


new window.Scena.Core

