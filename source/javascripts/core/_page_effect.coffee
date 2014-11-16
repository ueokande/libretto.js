window.Scena.pageEffects = {}

window.Scena.registerPageEffect = (name, animation) ->
  Scena.pageEffects[name.toLowerCase()] = animation

window.Scena.loadPageEffect = (name) ->
  name = name.toLowerCase()
  return null unless Scena.pageEffects.hasOwnProperty(name)
  return Scena.pageEffects[name]
