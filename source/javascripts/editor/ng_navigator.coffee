app = angular.module('scena_editor')
app.controller 'NavigatorController', ($scope, $rootScope, presentation) ->
  $scope.pages = presentation.pages()
  $scope.insertPage = ->
    presentation.insertPage()
    return true
  $setCurrentPage = (index) ->
    $rootScope.currentIndex = index

app.directive 'navigatorThumbnail', ->
  return {
    replace: true
    template: -> '''
      <div class='outer-capsule'>
        <div class='inner-capsule'>
        </div>
      </div>
      '''
    link: (scope, element) ->
      cloned = scope.page.cloneNode(true)
      for e in cloned.getElementsByTagName('*')
        e.removeAttribute('id')
      cloned.removeAttribute('id')
      element[0].firstElementChild.appendChild(cloned)
  }
