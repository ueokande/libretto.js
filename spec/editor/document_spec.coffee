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
    doc = Scena.Document.createDocument(text)

  afterEach ->
    doc.closeDocument()
    doc = null

  it 'creates a new document', ->
    expect(window.document.getElementById(Scena.Document.containerId)).not.toBeNull()
    doc.closeDocument()
    expect(window.document.getElementById(Scena.Document.containerId)).toBeNull()

  it 'returns current document', ->
    expect(Scena.Document.currentDocument()).toEqual(doc)

  it 'returns a page specified by page index', ->
    expect(doc.pageAt(0).id).toBe('a')
    expect(doc.pageAt(1).id).toBe('b')
    expect(doc.pageAt(9)).toBeNull()
    expect(doc.pageAt(-1)).toBeNull()

  it 'returns the number of the page', ->
    expect(doc.pageCount()).toBe(4)

  it 'returns the number of the page', ->
    pages = doc.pages()
    expect(pages.length).toBe(4)
    expect(pages[2]).toBe(doc.pageAt(2))

  xit 'generates the document as plain text', ->

  it 'deletes a page', ->
    doc.deletePage(3)
    expect(doc.pageCount()).toBe(3)

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
