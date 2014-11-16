class window.Scena.PageEffect

  before : (prevStyle, currentStyle, duration, options) ->
  exec : (prevStyle, currentStyle, duration, options) ->


class window.Scena.PageEffect.Default extends window.Scena.PageEffect

  exec: (prevStyle, currentStyle, duration, options) ->
    prevStyle.visibility = 'hidden'
    currentStyle.visibility = 'visible'

