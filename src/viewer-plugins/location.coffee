class window.Scena.Location extends window.Scena.Plugin

  initialize: =>
    window.addEventListener('hashchange', (e)=>
      @applyPage()
    )

    @core().addCurrentPageChangedListener(=>
      index = @core().getCurrentIndex()
      @setHash(index)
    )

    @applyPage()

  setHash: (index)=>
    window.location.hash = index + 1

  applyPage: ()->
    num = +(window.location.hash.split('#')[1])
    num = 1 if isNaN(num)
    @core().skipToPage(num - 1)


new window.Scena.Location

