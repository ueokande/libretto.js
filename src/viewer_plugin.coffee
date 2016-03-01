class Libretto.Plugin
  constructor: (name) ->
    window.addEventListener("load", @initialize)

  initialize: ->
