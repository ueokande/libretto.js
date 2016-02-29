describe 'Test of css.coffee', ->

  beforeEach ->
  afterEach ->

  it 'create new and finalizes', ->
    css = Libretto.Css.create('tested_css')
    styleEle = window.document.getElementById('tested_css')
    expect(styleEle).not.to.be.null

    css.finalize()
    styleEle = window.document.getElementById('tested_css')
    expect(styleEle).to.be.null

  it 'finds a exist css', ->
    css1 = Libretto.Css.create('tested_css')
    css2 = Libretto.Css.findById('tested_css')
    expect(css1.style).to.equal(css2.style)
    css1.finalize()

  it 'finds a exist css or creates new', ->
    css1 = Libretto.Css.findOrCreate('tested_css')
    css2 = Libretto.Css.findOrCreate('tested_css')
    expect(css1.style).to.equal(css2.style)
    css1.finalize()

  it 'adds rules with specifying style', ->
    css = Libretto.Css.create('tested_css')
    css.addRule('h2', {'color':'red'})
    css.addRule('h3', {'background-color':'blue'})
    expect(css.rules().length).to.equal(2)
    expect(css.rules()[0].style.color).to.equal('red')
    expect(css.rules()[1].style.backgroundColor).to.equal('blue')
    css.finalize()

  it 'applies to on-site HTML', ->
    div_by_id = window.document.createElement('div')
    div_by_id.id = 'div_id'
    div_by_class = window.document.createElement('div')
    div_by_class.className = 'div_cls'
    window.document.body.appendChild(div_by_id)
    window.document.body.appendChild(div_by_class)

    css = Libretto.Css.create('tested_css')
    css.addRule('#div_id', {'color':'red'})
    css.addRule('.div_cls', {'background-color':'blue'})

    expect(window.getComputedStyle(div_by_id).color).to.equal('rgb(255, 0, 0)')
    expect(window.getComputedStyle(div_by_class).backgroundColor).to.equal('rgb(0, 0, 255)')

    css.finalize()
    window.document.body.removeChild(div_by_id)
    window.document.body.removeChild(div_by_class)

  it 'clears rules', ->
    css = Libretto.Css.create('tested_css')
    css.addRule('h2', {'color':'red'})
    css.addRule('h3', {'background-color':'blue'})
    css.clearRules()
    expect(css.rules().length).to.equal(0)
    css.finalize()

