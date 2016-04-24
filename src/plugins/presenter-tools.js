class PresenterTool extends Libretto.Plugin {
  initialize() {
    window.addEventListener('keypress', (e) => {
      if (e.charCode == 'p'.charCodeAt(0)) {
        if (typeof this.toolWindow === 'undefined') {
          this.toolWindow = window.open('about:blank', 'Presenter Tools',
                                   'width=400');
          this.initializeDom();
          this.toolWindow.addEventListener('keypress', (e) => {
            e.target.ownerDocument.defaultView.close();
            delete this.toolWindow;
          });
          Libretto.IO.registerEvents(this.toolWindow);
        }
      }
    });
  }

  initializeDom() {
    this.toolWindow.document.body.innerHTML =
      '<div id="current_page"></div>' +
      '<div id="next_page"></div>' +
      '<style>' +
      '#current_page, #next_page {' +
      '  margin: 32px;' +
      '  box-shadow: 0 0 8px black;' +
      '}' +
      '</style>'
    this.currentPageViewer = this.toolWindow.document.getElementById('current_page');
    this.nextPageViewer = this.toolWindow.document.getElementById('next_page');
    this.updatePages();
  }

  updatePages() {
    let viewer = Libretto.Viewer.viewer();
    function updatePreview() {
      let index = viewer.getCurrentIndex();
      this.currentPageViewer.innerHTML = '';
      this.nextPageViewer.innerHTML = '';

      let currentPage = Libretto.Page.pageAt(index);
      let element= currentPage.element.cloneNode(true);
      this.currentPageViewer.appendChild(element);

      if (Libretto.Page.count() > index + 1) {
        let nextPage = Libretto.Page.pageAt(index + 1);
        let element = nextPage.element.cloneNode(true);
        this.nextPageViewer.appendChild(element);
      }
    }
    viewer.addCurrentPageChangedListener(() => {
      updatePreview.call(this);
    });
    updatePreview.call(this);
  }
}

Libretto.PresenterTool = new PresenterTool();
