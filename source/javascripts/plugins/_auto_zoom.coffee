class Libretto.AutoZoom extends window.Libretto.Plugin
  initialize: =>
    @initialBodyWidth = bodyWidth.call(@)
    @initialBodyHeight = bodyHeight.call(@)
    window.addEventListener('resize', @fitToWindow)
    @fitToWindow()

  fitToWindow: (e) =>
    iw = window.innerWidth
    ih = window.innerHeight
    zoom = Math.min(iw / @initialBodyWidth, ih / @initialBodyHeight)
    window.document.body.style.transform = "scale(#{zoom})"
    window.document.body.style.transformOrigin = "0 0"

  bodyWidth = ->
    window.getComputedStyle(window.document.body).width.split('px')[0]

  bodyHeight = ->
    window.getComputedStyle(window.document.body).height.split('px')[0]

new window.Libretto.AutoZoom
