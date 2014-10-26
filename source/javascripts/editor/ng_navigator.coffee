#= require ./ng_presentation

app = angular.module('scena_editor')
app.controller 'NavigatorController', ($scope, $rootScope, presentation) ->
  $scope.pages = presentation.pages()
  $scope.insertPage = ->
    page = presentation.insertPage()
    return true
  $scope.setCurrentPage = (index) ->
    $rootScope.currentIndex = index
  $scope.overedIndex = -1
  $scope.moveFromIndex = -1

  $scope.dragStart = (index) ->
    $scope.$apply -> $scope.moveFromIndex = index

  $scope.dragEnd = (index) ->
    $scope.$apply ->
      $scope.overedIndex = -1
      $scope.moveFromIndex = -1

  $scope.dragEnter = (index) ->
    return if index == $scope.moveFromIndex
    return if index == $scope.moveFromIndex + 1
    $scope.$apply -> $scope.overedIndex = index

  $scope.dragLeave = (index) ->
    $scope.$apply -> $scope.overedIndex = -1

  $scope.drop = (index) ->
    return if $scope.moveFromIndex == -1
    $scope.$apply -> presentation.movePage($scope.moveFromIndex, index)

  $scope.appenPage = ->
    presentation.insertPage

app.directive 'navigatorThumbnail', ->
  return (scope, element, attrs) ->
    cloned = scope.page.cloneNode(true)
    for e in cloned.getElementsByTagName('*')
      e.removeAttribute('id')
    cloned.removeAttribute('id')
    html = """
      <div class='inner-capsule'>
        #{cloned.outerHTML}
      </div>
    """
    ele = element[0]
    ele.innerHTML = html
    ele.addEventListener 'dragstart', (e) ->
      e.dataTransfer.effectAllowed = 'move'
      scope.dragStart(scope.$index)
    ele.addEventListener 'dragend', -> scope.dragEnd(scope.$index)
    ele.addEventListener 'dragenter', -> scope.dragEnter(scope.$index)
    ele.addEventListener 'dragover', (e) ->
      e.preventDefault()
      e.dataTransfer.dropEffect = 'move'
    ele.addEventListener 'dragleave', -> scope.dragLeave(scope.$index)
    ele.addEventListener 'drop', (e) ->
      e.stopPropagation()
      scope.drop(scope.$index)
