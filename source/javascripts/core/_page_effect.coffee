window.Libretto.pageEffects = {}

window.Libretto.registerPageEffect = (name, animation) ->
  Libretto.pageEffects[name.toLowerCase()] = animation

window.Libretto.loadPageEffect = (name) ->
  name = name.toLowerCase()
  return null unless Libretto.pageEffects.hasOwnProperty(name)
  return Libretto.pageEffects[name]
