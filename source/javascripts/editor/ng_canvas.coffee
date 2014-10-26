#= require ./ng_presentation

app = angular.module('scena_editor')
app.controller 'CanvasController', ($scope, $rootScope, presentation) ->

app.directive 'mainCanvas', ($rootScope, presentation) ->
  return (scope, element) -> scope.$watch 'currentIndex', ->
      return if $rootScope.currentIndex == undefined
      cloned = presentation.pageAt(scope.currentIndex)
      ele = element[0]
      ele.innerHTML = cloned.outerHTML
