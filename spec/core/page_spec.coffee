describe 'Test of page.coffee', ->

  elements = null

  beforeEach ->
    elements = [null, null, null]
    for i,_ of elements
      elements[i] =  window.document.createElement('section')
      window.document.body.appendChild(elements[i])

  afterEach ->
    for ele in elements
      window.document.body.removeChild(ele)
    elements = null

  it 'returns the number of the page in the document', ->
    expect(Scena.Page.count()).toBe(3)

  it 'returns a page object of the specified by index', ->
    object = Scena.Page.pageAt(1)
    expect(object.element).toBe(window.document.body.getElementsByTagName('section')[1])

  it 'returns an effect name if the name is given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    pageEle.setAttribute('effect', 'my_effect')
    page = Scena.Page.pageAt(1)
    expect(page.animationEffect()).toBe('my_effect')

  it 'returns null if the name is not given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    page = Scena.Page.pageAt(1)
    expect(page.animationEffect()).toBeNull()

  it 'return a effect duration if the duration is given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    pageEle.setAttribute('duration', '500ms')
    page = Scena.Page.pageAt(1)
    expect(page.animationDuration()).toBe('500ms')

  it 'return null if the duration is not given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    page = Scena.Page.pageAt(1)
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

  # it 'createAnimation()', ->
