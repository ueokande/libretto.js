#= require ./ng_presentation

app = angular.module('scena_editor')
app.controller 'Develop', ($scope, $rootScope, presentation) ->
  $scope.debugInit = ->
    src = '''
      <html>
        <head>
          <title>Hello Editor Title</title>
        </head>
        <body>
          <section id='a'>
            <h1>Hello</h1>
          </section>
          <section id='b'>
            <h1>This is </h1>
          </section>
          <section id='c'>
            <h1>a</h1>
          </section>
          <section id='d'>
            <h1>pen</h1>
          </section>
        </body>
      </html>
    '''
    presentation.loadFromText(src)
