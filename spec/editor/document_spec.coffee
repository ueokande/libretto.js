describe 'Test of document.coffee', ->

  doc = null

  beforeEach ->
    text = '''
      <html>
        <head>
          <title>Hello Editor Title</title>
        </head>
        <body>
          <section id='a'></section>
          <section id='b'></section>
          <section id='c'></section>
          <section id='d'></section>
        </body>
      </html>
      '''
    doc = new Scena.Document(text)

  afterEach ->
    doc.finalize()
    doc = null

  it 'constructs and finalizes a document', ->
    container = window.document.getElementById('scena-editor-container')
    expect(container.getElementsByTagName('title')[0].innerHTML).toBe('Hello Editor Title')
    expect(container.getElementsByTagName('section')[0].id).toBe('a')

    doc.finalize()
    expect(window.document.getElementById('a')).toBeNull()

  it 'returns a page specified by page index', ->
    expect(doc.pageAt(0).id).toBe('a')
    expect(doc.pageAt(1).id).toBe('b')
    expect(doc.pageAt(9)).toBeNull()
    expect(doc.pageAt(-1)).toBeNull()

  it 'returns the number of the page', ->
    expect(doc.pageCount()).toBe(4)

  xit 'generates the document as plain text', ->

  it 'adds a page into first and middle', ->
    doc.addPage(0)
    expect(doc.pageCount()).toBe(5)
    expect(doc.pageAt(1).id).toBe('a')
    expect(doc.pageAt(2).id).toBe('b')

    doc.addPage(9)
    expect(doc.pageCount()).toBe(6)
    expect(doc.pageAt(1).id).toBe('a')
    expect(doc.pageAt(2).id).toBe('b')

    doc.addPage(-1)
    expect(doc.pageCount()).toBe(7)
    expect(doc.pageAt(2).id).toBe('a')
    expect(doc.pageAt(3).id).toBe('b')

  it 'moves a page', ->
    doc.movePage(2, 0)
    expect(doc.pageAt(0).id).toBe('c')
    expect(doc.pageAt(1).id).toBe('a')
    expect(doc.pageAt(2).id).toBe('b')
    expect(doc.pageAt(3).id).toBe('d')

    doc.movePage(2, 9)
    expect(doc.pageAt(0).id).toBe('c')
    expect(doc.pageAt(1).id).toBe('a')
    expect(doc.pageAt(2).id).toBe('d')
    expect(doc.pageAt(3).id).toBe('b')

    doc.movePage(2, -1)
    expect(doc.pageAt(0).id).toBe('d')
    expect(doc.pageAt(1).id).toBe('c')
    expect(doc.pageAt(2).id).toBe('a')
    expect(doc.pageAt(3).id).toBe('b')
