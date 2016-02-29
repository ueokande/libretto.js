describe 'Test of page_transition.coffee', ->
  beforeEach ->
    @pageEle1 = window.document.createElement('section')
    @pageEle2 = window.document.createElement('section')
    @pageEle1.style.position = 'absolute'
    @pageEle2.style.position = 'absolute'
    window.document.body.appendChild(@pageEle1)
    window.document.body.appendChild(@pageEle2)

    @prevPage = new Libretto.Page(@pageEle1)
    @nextPage = new Libretto.Page(@pageEle2)

  afterEach ->
    window.document.body.removeChild(@pageEle1)
    window.document.body.removeChild(@pageEle2)
    @prevPage = null
    @nextPage = null
    @pageEle1 = null
    @pageEle2 = null

  it 'constructs and destructs a object', ->
    pageTransition = new Libretto.PageTransition(0, 1, @nextPage, 'TestPageTransition')
    styleEle = window.document.getElementById('TestPageTransition')
    expect(styleEle).not.to.be.null

    pageTransition.finalize()
    styleEle = window.document.getElementById('TestPageTransition')
    expect(styleEle).to.be.null

  it 'switches the page without transition', ->
    pageTransition = new Libretto.PageTransition(0, 1, @nextPage, 'TestPageTransition')
    pageTransition.switchPage(false)

    expect(window.getComputedStyle(@pageEle1).zIndex) \
      .to.be.below(window.getComputedStyle(@pageEle2).zIndex)

    pageTransition.finalize()

  xit 'switches the page with transition', ->
