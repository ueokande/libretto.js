app = angular.module('scena_editor')

app.factory 'RubberBandModel', ->
  class RubberBandModel
    constructor: ->
      @dragging = false
      @visibility = 'hidden'
    begin: (@beginX, @beginY) ->
      @dragging = true
      @visibility = 'visible'
    update: (x, y) ->
      if @dragging
        @currentX = x
        @currentY = y
    end: ->
      @dragging = false
      @visibility = 'hidden'
    left :   -> Math.min(@beginX, @currentX)
    top :    -> Math.min(@beginY, @currentY)
    width :  -> Math.abs(@beginX - @currentX)
    height : -> Math.abs(@beginY - @currentY)

app.factory 'rubberBandService', (RubberBandModel) ->
  model = new RubberBandModel()
  return -> model

app.controller 'RubberBandController', ($scope, $rootScope, rubberBandService) ->
  model = rubberBandService()
  $scope.rubberBandStyle = ->
    'pointer-events' : 'none'
    position   : 'absolute'
    border     : '1px dashed #888'
    visibility : "#{model.visibility}"
    left       : "#{model.left()}px"
    top        : "#{model.top()}px"
    width      : "#{model.width()}px"
    height     : "#{model.height()}px"
