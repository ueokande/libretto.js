describe 'Test of page.coffee', ->

  it 'animationEffect() of given effect', ->
    pageEle = window.document.createElement('section')
    pageEle.setAttribute('effect', 'my_effect')
    page = new Scena.Page(pageEle)
    expect(page.animationEffect()).toBe('my_effect')

  it 'animationEffect() of non-given effect', ->
    pageEle = window.document.createElement('section')
    page = new Scena.Page(pageEle)
    expect(page.animationEffect()).toBeNull()

  it 'animationDuration() of given duration', ->
    pageEle = window.document.createElement('section')
    pageEle.setAttribute('duration', '500ms')
    page = new Scena.Page(pageEle)
    expect(page.animationDuration()).toBe('500ms')

  it 'animationDuration() of non-given duration', ->
    pageEle = window.document.createElement('section')
    page = new Scena.Page(pageEle)
    expect(page.animationDuration()).toBeNull()

  # it 'animationOptions() of given options', ->
  #   pageEle = window.document.createElement('section')
  #   pageEle.setAttribute('direction', 'up')
  #   pageEle.setAttribute('fog', 'true')
  #   page = new Scena.Page(pageEle)
  #   options = pageEle.options()
  #   expect(options.length).toBe(2)
  #   expect(options['direction']).toBe('up')
  #   expect(options['fog']).toBe('true')

  # it 'animationOptions() of non-given options', ->
  #   pageEle = window.document.createElement('section')
  #   pageEle.setAttribute('direction', 'up')
  #   pageEle.setAttribute('fog', 'true')
  #   page = new Scena.Page(pageEle)
  #   options = pageEle.options()
  #   expect(options.length).toBe(0)

  # it 'setClassAsPrevious()', ->
  # it 'setClassAsNext()', ->
  # it 'resetClasses()', ->
  # it 'createAnimation()', ->
