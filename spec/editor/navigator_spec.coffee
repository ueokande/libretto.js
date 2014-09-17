describe 'Test of navigator.coffee', ->

  doc = null
  navigator = null
  navigatorEle = null

  beforeEach ->
    text = '''
      <html>
        <head>
          <title>Hello Editor Title</title>
        </head>
        <body>
          <section id='id_a' class='class_a'></section>
          <section id='id_b' class='class_b'></section>
          <section id='id_c' class='class_c'></section>
          <section id='id_d' class='class_d'></section>
        </body>
      </html>
      '''
    doc = Scena.Document.createDocument(text)

    navigatorEle = document.createElement('div')
    document.body.appendChild(navigatorEle)
    navigator = new Scena.Navigator(navigatorEle)

  afterEach ->
    document.body.removeChild(navigatorEle)
    navigatorEle
    navigator.finalize()
    doc.closeDocument()
    doc = null

  pageElementAt = (index) ->
    navigator.dom.children[index].children[0].children[0]

  xit 'constructs and finalize an object', ->

  it 'updates all pages', ->
    navigator.updateAll()
    expect(navigator.dom.children.length).toBe(4)
    expect(pageElementAt(2).className).toBe('class_c')

  it 'refreshes specified page', ->
    expect(pageElementAt(2).className).toBe('class_c')
    doc.pageAt(2).className = 'changed'
    expect(pageElementAt(2).className).toBe('class_c')
    navigator.refreshPage(2)
    expect(pageElementAt(2).className).toBe('changed')

  it 'moves a page into specified position', ->
    expect(doc.pageAt(0).id).toBe('id_a')
    expect(doc.pageAt(1).id).toBe('id_b')
    expect(doc.pageAt(2).id).toBe('id_c')
    expect(doc.pageAt(3).id).toBe('id_d')
    expect(pageElementAt(0).className).toBe('class_a')
    expect(pageElementAt(1).className).toBe('class_b')
    expect(pageElementAt(2).className).toBe('class_c')
    expect(pageElementAt(3).className).toBe('class_d')

    navigator.movePage(2,0)
    expect(doc.pageAt(0).id).toBe('id_c')
    expect(doc.pageAt(1).id).toBe('id_a')
    expect(doc.pageAt(2).id).toBe('id_b')
    expect(doc.pageAt(3).id).toBe('id_d')
    expect(pageElementAt(0).className).toBe('class_c')
    expect(pageElementAt(1).className).toBe('class_a')
    expect(pageElementAt(2).className).toBe('class_b')
    expect(pageElementAt(3).className).toBe('class_d')

    navigator.movePage(0,4)
    expect(doc.pageAt(0).id).toBe('id_a')
    expect(doc.pageAt(1).id).toBe('id_b')
    expect(doc.pageAt(2).id).toBe('id_d')
    expect(doc.pageAt(3).id).toBe('id_c')
    expect(pageElementAt(0).className).toBe('class_a')
    expect(pageElementAt(1).className).toBe('class_b')
    expect(pageElementAt(2).className).toBe('class_d')
    expect(pageElementAt(3).className).toBe('class_c')

  it 'deletes a page', ->
    navigator.deletePage(2)
    expect(navigator.dom.children.length).toBe(3)
    expect(doc.pageCount()).toBe(3)

  it 'adds a page', ->
    navigator.addPage(1)
    expect(doc.pageAt(0).id).toBe('id_a')
    expect(doc.pageAt(2).id).toBe('id_b')
    expect(pageElementAt(0).className).toBe('class_a')
    expect(pageElementAt(2).className).toBe('class_b')

