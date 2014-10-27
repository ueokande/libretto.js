#= require ./ng_presentation

app = angular.module('scena_editor')
app.controller 'CanvasController', ($scope, $rootScope,
                                    presentation, rubberBandService) ->
  $scope.mouseDown = (e) ->
    rubberBandService().begin(e.x, e.y)
  $scope.mouseUp = (e) ->
    rubberBandService().end()
  $scope.mouseMove = (e) ->
    rubberBandService().update(e.x, e.y)
  $scope.doubleClick = (e) ->

app.directive 'mainCanvas', ($rootScope, presentation) ->
  return (scope, element) -> scope.$watch 'currentIndex', ->
    return if scope.currentIndex == undefined
    unless scope.prevIndex == undefined or scope.prevIndex == null
      presentation.commitPage(scope.prevIndex, scope.currentPage)
    currentPage = presentation.pageAt(scope.currentIndex).cloneNode(true)
    element[0].appendChild(currentPage)
    scope.currentPage = currentPage
    scope.prevIndex = scope.currentIndex
