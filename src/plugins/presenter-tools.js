class PresenterTool extends Libretto.Plugin {
  initialize() {
    window.addEventListener('keypress', (e) => {
      if (e.charCode == 'p'.charCodeAt(0)) {
        if (typeof this.toolWindow === 'undefined') {
          this.toolWindow = window.open('about:blank', 'Presenter Tools',
                                   'width=400');
          this.toolWindow.addEventListener('keypress', (e) => {
            e.target.ownerDocument.defaultView.close();
            delete this.toolWindow;
          });
          Libretto.IO.registerEvents(this.toolWindow);
        }
      }
    });
  }
}

Libretto.PresenterTool = new PresenterTool();
