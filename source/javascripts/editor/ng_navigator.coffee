#= require ./ng_presentation

app = angular.module('scena_editor')
app.controller 'NavigatorController', ($scope, $rootScope, presentation) ->
  $scope.pages = presentation.pages()
  $scope.insertPage = ->
    page = presentation.insertPage()
    return true
  $scope.setCurrentPage = (index) ->
    $rootScope.currentIndex = index

  $scope.dragStart = (index) ->
    return console.debug "dtart start @#{index}"
    e.dataTransfer.effectAllowed = 'move'
    @draggedEle = e.target
    @draggedEle.classList.add('dragged')
  $scope.dragEnd = (index) ->
    return console.debug "dtart end @#{index}"
    for c in @dom.children
      c.classList.remove('over')
    @draggedEle.classList.remove('dragged')
    @draggedEle = null
  $scope.dragEnter = (index) ->
    return console.debug "dtart enter @#{index}"
    return if e.target == @draggedEle
    return if e.target == @draggedEle.nextSibling
    e.target.classList.add('over')
  $scope.dragOver = (index) ->
    return console.debug "dtart over @#{index}"
    e.preventDefault()
    e.dataTransfer.dropEffect = 'move'
  $scope.dragLeave = (index) ->
    return console.debug "dtart leave @#{index}"
    @.classList.remove('over')
  $scope.drop = (index) ->
    return console.debug "drop @#{index}"
    e.stopPropagation()
    return if @draggedEle == null
    indexFrom = @indexOfChild(@draggedEle)
    indexTo = @indexOfChild(e.target)
    @movePage(indexFrom, indexTo)
    return false

app.directive 'navigatorThumbnail', ->
  return {
    replace: true
    link: (scope, element, attrs) ->
      cloned = scope.page.cloneNode(true)
      for e in cloned.getElementsByTagName('*')
        e.removeAttribute('id')
      cloned.removeAttribute('id')
      html = """
        <div class='inner-capsule'>
          #{cloned.outerHTML}
        </div>
      """
      element[0].innerHTML = html
  }
