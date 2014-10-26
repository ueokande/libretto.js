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
    return if $rootScope.currentIndex == undefined
    cloned = presentation.pageAt(scope.currentIndex)
    ele = element[0]
    ele.innerHTML = cloned.outerHTML
