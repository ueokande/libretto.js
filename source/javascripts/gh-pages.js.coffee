window.onload = (e) ->
  editor = window.document.getElementById('editor')
  commit_button= window.document.getElementById('commit-button')
  preview = window.document.getElementById('preview')

  commit = ->
    preview.srcdoc = editor.value
    console.debug editor.value

  commit_button.onclick = -> commit()

  editor.value = '''
  <!DOCTYPE html>
  <head>
    <link href="/stylesheets/scena.css" rel="stylesheet"
     type="text/css">
    <link href="/stylesheets/themes/simple.css" rel="stylesheet"
     type="text/css">
    <script src="/javascripts/scena.js" type="text/javascript"></script>
    <style>
      body { width: 1344px; height: 756px; }
      .box {
        display:inline-block;
        position:absolute;
        width:48px; height:48px;
      }
    </style>
  </head>
  <body>
    <section class='title'>
      <h1>Scena.js</h1>
      <h2>An HTML basec presentation framework</h2>
      <hr>
      <h3>Click me!</h3>
    </section>
    <section effect='Push'>
      <h1>Why use scena.js?</h1>
      <h2>Free and open source software</h2>
      <ul>
        <li>Scena.js is a Free/Open software based on HTML5</li>
        <li>You can provide your presentation on any platform</li>
      </ul>

      <h2>Animations</h2>
      <p class='pagenum'></p>
      <ul>
        <li>The animation is implements with CSS transitions
            and extended tags</li>
        <li>Make them freedom!</li>
      </ul>
      <div style="margin:32px">
        <span id="after1" class='box'
              style="left:128px; background-color:red"> </span>
        <span id="after2" class='box'
              style="left:256px; background-color:green"></span>
        <span id="after3" class='box'
              style="left:384px; background-color:blue"></span>
      </div>
      <animation>
        <keyframe target="#after1" duration="500ms"
         margin-left="80px" transform='rotate(90deg)' ></keyframe>
        <keyframe target="#after2" duration="500ms" timing="after"
         margin-left="80px" transform='rotate(90deg)'  ></keyframe>
        <keyframe target="#after3" duration="500ms" timing="after"
         margin-left="80px" transform='rotate(90deg)'  ></keyframe>
      </animation>
    </section>

    <section effect='Push'>
      <h1>Miscellaneous</h1>
      <p class='pagenum'></p>
      <h2>Join to contribution</h2>
      <ul>
        <li>Fork me on
          <a href='https://github.com/iBenza/Scena.js'>Github</a>
        </li>
      </ul>
      <h2>Future works</h2>
      <ul>
        <li>Front-end editor</li>
        <li>Markdown</li>
      </ul>
    </section>
  </body>
  '''

  commit()
