#
# Scena.MainCanvas class
#
class window.Scena.MainCanvas
  constructor: (@dom) ->
    @selectionChangesListeners = []

    rubber_band_ele = document.createElement('div')
    @dom.appendChild(rubber_band_ele)
    @rubber_band = new Scena.RubberBand(rubber_band_ele)

    @dragging = false

    @dom.addEventListener('mousedown', @mouseDown)
    @dom.addEventListener('mouseup', @mouseUp)
    @dom.addEventListener('mousemove', @mouseMove)


  selectedItems: ->

  addSelectionChangesListener: (listener) ->
    @selectionChangesListeners.push(listener)

  mouseDown: (e) =>
    under = window.document.elementFromPoint(e.clientX, e.clientY)
    if under == @dom
      eleX = e.clientX - @dom.offsetLeft
      eleY = e.clientY - @dom.offsetTop
      @rubber_band.startRubberBand(eleX, eleY)
      @dragging = true

  mouseUp: (e) =>
    @dragging = false
    @rubber_band.stopRubberBand()

  mouseMove: (e) =>
    if @dragging
      eleX = e.clientX - @dom.offsetLeft
      eleY = e.clientY - @dom.offsetTop
      @rubber_band.updateRubberBand(eleX, eleY)
