#
# Libretto.EventListener class
#
class Libretto.EventListener
  addEventListener: (name, handler) ->
    @listeners = {} if @listeners == undefined
    unless @listeners.hasOwnProperty(name)
      @listeners[name] = [handler]
    else
      @listeners[name].push(handler)

  invokeEventListeners: (name) ->
    return if @listeners == undefined
    return unless @listeners.hasOwnProperty(name)
    for l in @listeners[name]
      l()
