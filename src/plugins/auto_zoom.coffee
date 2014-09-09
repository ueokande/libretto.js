class Scena.AutoZoom extends window.Scena.Plugin
  initialize: =>
    @initialBodyWidth = bodyWidth.call(@)
    @initialBodyHeight = bodyHeight.call(@)
    window.addEventListener('resize', @fitToWindow)
    @fitToWindow()

  fitToWindow: (e) =>
    iw = window.innerWidth
    ih = window.innerHeight
    zoom = Math.min(iw / @initialBodyWidth, ih / @initialBodyHeight)
    console.debug "#{iw} / #{@initialBodyWidth}"
    window.document.body.style.zoom = zoom
    console.debug "#{ih} / #{@initialBodyHeight}"

  bodyWidth = ->
    window.getComputedStyle(window.document.body).width.split('px')[0]

  bodyHeight = ->
    window.getComputedStyle(window.document.body).height.split('px')[0]

new window.Scena.AutoZoom
