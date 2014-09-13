describe 'Test of document.coffee', ->

  beforeEach ->

  afterEach ->

  it 'constructs and finalizes a document', ->
    text = '''
      <html>
        <body>
          <title>Hello Editor Title</title>
        </body>
        <body>
          <section id='hello-editor-id'>
        </body>
      </html>
      '''
    document = new Scena.Document(text)
    container = window.document.getElementById('scena-editor-container')
    expect(container.getElementsByTagName('title')[0].innerHTML).toBe('Hello Editor Title')
    expect(container.getElementsByTagName('section')[0].id).toBe('hello-editor-id')

    document.finalize()
    expect(window.document.getElementById('hello-editor-id')).toBeNull()


  it 'returns a page specified by page index', ->
    text = '''
      <html>
        <body>
          <section id='hello-page-a'></section>
          <section id='hello-page-b'></section>
        </body>
      </html>
      '''
    document = new Scena.Document(text)

    expect(document.pageAt(0).id).toBe('hello-page-a')
    expect(document.pageAt(1).id).toBe('hello-page-b')
    expect(document.pageAt(2)).toBeNull()

    document.finalize()
