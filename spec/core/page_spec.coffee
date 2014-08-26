describe 'Test of page.coffee', ->

  it 'returns an effect name if the name is given', ->
    pageEle = window.document.createElement('section')
    pageEle.setAttribute('effect', 'my_effect')
    page = new Scena.Page(pageEle)
    expect(page.animationEffect()).toBe('my_effect')

  it 'returns null if the name is not given', ->
    pageEle = window.document.createElement('section')
    page = new Scena.Page(pageEle)
    expect(page.animationEffect()).toBeNull()

  it 'return a effect duration if the duration is given', ->
    pageEle = window.document.createElement('section')
    pageEle.setAttribute('duration', '500ms')
    page = new Scena.Page(pageEle)
    expect(page.animationDuration()).toBe('500ms')

  it 'return null if the duration is not given', ->
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
