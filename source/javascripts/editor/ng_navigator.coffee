app = angular.module('scena_editor')
app.controller 'NavigatorController', ($scope, presentation) ->
  $scope.pages = presentation.pages()
  $scope.insertPage = ->
    presentation.insertPage()
    return true
  dom = document.createElement('span')
  $scope.container = [1,  2,3]

app.directive 'thumbnailList', ->
  return {
    link: (scope, element) ->
      container = element[0]
      for page in scope.pages
        cloned = page.cloneNode(true)
        for e in cloned.getElementsByTagName('*')
          e.removeAttribute('id')
        cloned.removeAttribute('id')
        inner = document.createElement('div')
        inner.classList.add('inner-capsule')
        inner.appendChild(cloned)
        outer = document.createElement('div')
        outer.setAttribute('draggable', true)
        outer.classList.add('outer-capsule')
        outer.appendChild(inner)
        container.appendChild(outer)
  }
