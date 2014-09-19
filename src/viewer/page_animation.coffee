class window.Scena.PageAnimation

  #
  #
  #
  constructor: (@prevIndex, @nextIndex, @nextPage, styleName) ->
    styleName = 'PageAnimation' if styleName is undefined
    @pageAnimeCss = new Scena.Css(styleName)

  #
  #
  #
  finalize: ->
    @pageAnimeCss.finalize()

  #
  #
  #
  switchPage: (animationEnable) ->
    if animationEnable
      animatePage.call(@)
    else
      noAnimatePage.call(@)

  #
  #
  #
  noAnimatePage = ->
    effect = new Scena.PageEffect
    execAnime.call(@, effect, null, null)

  #
  #
  #
  animatePage = ->
    effectName = @nextPage.animationEffect()
    duration = @nextPage.animationDuration()
    options = @nextPage.animationOptions()

    if effectName == null
      effectClass = Scena.PageEffect.Default
    else if Scena.PageEffect[effectName] isnt undefined
      effectClass = Scena.PageEffect[effectName]
    else
      console.warn("No such page effect : #{effectName}")
      effectClass = Scena.PageEffect.Default

    effect = new effectClass

    execAnime.call(@, effect, duration, options)

  #
  #
  #
  execAnime = (effect, duration, options) ->
    @pageAnimeCss.clearRules()
    if @prevIndex isnt null
      prevStyle = @pageAnimeCss.addRule("section:nth-of-type(#{@prevIndex+1})")
      prevStyle.visibility = 'visible'
      prevStyle.zIndex = 0
    nextStyle = @pageAnimeCss.addRule("section:nth-of-type(#{@nextIndex+1})")
    nextStyle.visibility = 'visible'
    nextStyle.zIndex = 1

    effect.before(prevStyle, nextStyle, duration, options)
    setTimeout(->
      effect.exec(prevStyle, nextStyle, duration, options)
    , 0)

