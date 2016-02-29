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

  it 'returns the number of the page which has body as parent', ->
    grandchildElement = document.createElement('section')
    elements[1].appendChild(grandchildElement)
    expect(Libretto.Page.count()).to.equal(3)

  it 'returns a page object of the specified by index', ->
    grandchildElement = document.createElement('section')
    elements[1].appendChild(grandchildElement)
    object = Libretto.Page.pageAt(2)

    childSections = []
    for c in window.document.body.children
      childSections.push(c) if c.tagName.match(/section/i)
    expect(object.element).to.equal(childSections[2])

  it 'returns an index of the pages', ->
    grandchildElement = document.createElement('section')
    expect(Libretto.Page.pageAt(1).indexOf()).to.equal(1)

  it 'returns an effect name if the name is given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    pageEle.setAttribute('effect', 'my_effect')
    page = Libretto.Page.pageAt(1)
    expect(page.animationEffect()).to.equal('my_effect')

  it 'returns null if the name is not given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    page = Libretto.Page.pageAt(1)
    expect(page.animationEffect()).to.be.null

  it 'return a effect duration if the duration is given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    pageEle.setAttribute('duration', '500ms')
    page = Libretto.Page.pageAt(1)
    expect(page.animationDuration()).to.equal('500ms')

  it 'return null if the duration is not given', ->
    pageEle = window.document.body.getElementsByTagName('section')[1]
    page = Libretto.Page.pageAt(1)
    expect(page.animationDuration()).to.be.null

  # it 'animationOptions() of given options', ->
  #   pageEle = window.document.createElement('section')
  #   pageEle.setAttribute('direction', 'up')
  #   pageEle.setAttribute('fog', 'true')
  #   page = new Libretto.Page(pageEle)
  #   options = pageEle.options()
  #   expect(options.length).to.equal(2)
  #   expect(options['direction']).to.equal('up')
  #   expect(options['fog']).to.equal('true')

  # it 'animationOptions() of non-given options', ->
  #   pageEle = window.document.createElement('section')
  #   pageEle.setAttribute('direction', 'up')
  #   pageEle.setAttribute('fog', 'true')
  #   page = new Libretto.Page(pageEle)
  #   options = pageEle.options()
  #   expect(options.length).to.equal(0)

  # it 'createAnimation()', ->
