class window.Scena.Viewer

  @viewer: ->
    window.Scena.viewer

  #
  # Initializes internal variables and HTML contents.
  #
  constructor: ->
    @currentAnimation = null
    @currentIndex = null
    @pageTransition = null
    @currentPageChangedListeners = []

    window.Scena.viewer = @

  getCurrentIndex: ->
    @currentIndex

  #
  # Skips to specified page without animation.
  #
  skipToPage: (index) ->
    return if Scena.Page.count() == 0
    switchPage.call(@, index, false)

  #
  #
  #
  animateToPage: (index) ->
    return if Scena.Page.count() == 0
    switchPage.call(@, index, true)

  #
  #
  #
  switchPage = (index, animationEnable) ->
    index = Math.max(0, index)
    index = Math.min(Scena.Page.count() - 1, index)
    return if index is @currentIndex

    prevIndex = @currentIndex
    nextIndex = index
    currentPage = Scena.Page.pageAt(index)
    @currentIndex = index
    @currentAnimation = currentPage.animation()
    @currentAnimation.reset()

    @pageTransition.finalize() if @pageTransition isnt null
    @pageTransition = new Scena.PageTransition(prevIndex, nextIndex, currentPage)
    @pageTransition.switchPage(animationEnable)

    l() for l in @currentPageChangedListeners

  #
  # Animate the element of page to next.
  #
  nextStep: ->
    if !@currentAnimation.hasNextKeyframe()
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
    @skipToPage(Scena.Page.count() - 1)

  #
  #
  #
  addCurrentPageChangedListener: (listener) ->
    @currentPageChangedListeners.push(listener)


new window.Scena.Viewer

