#
# Scena.RubberBand class
#
class window.Scena.RubberBand
  constructor: (@dom) ->
    @dom.style.position = 'absolute'
    @dom.style.border = '1px dashed #888'
    @startX = 0
    @startY = 0
    @currentX = 0
    @currentY = 0

  startRubberBand: (x, y) ->
    @startX = x
    @startY = y
    @currentX = x
    @currentY = y
    updateStyle.call(@)
    @dom.style.visibility = 'visible'

  stopRubberBand: () ->
    @dom.style.visibility = 'hidden'

  updateRubberBand: (x,y) ->
    @currentX = x
    @currentY = y
    updateStyle.call(@)

  updateStyle = ->
    @dom.style.left   = "#{@x()}px"
    @dom.style.top    = "#{@y()}px"
    @dom.style.width  = "#{@width()}px"
    @dom.style.height = "#{@height()}px"

  x: -> Math.min(@startX, @currentX)
  y: -> Math.min(@startY, @currentY)
  width: -> Math.abs(@startX - @currentX)
  height: -> Math.abs(@startY - @currentY)
