class IO extends Libretto.Plugin {
  initialize() {
    window.addEventListener('keypress', (e) => {
      let viewer = Libretto.viewer();
      if (e.charCode == '['.charCodeAt(0)) {
        viewer.skipToPrevPage();
      } else if (e.charCode == ']'.charCodeAt(0)) {
        viewer.skipToNextPage();
      }
    });

    window.addEventListener('keydown', (e) => {
      // TODO: Added Enter key but the Enter is conflicted to pager plugin.
      let viewer = Libretto.viewer();
      switch (e.keyCode) {
      // case 13:    // Enter
      case 32:  // Space
      case 40:  // Arrow Down
      case 34:  // Page Down
        viewer.nextStep();
        break;
      case 38:  // Arrow up
      case 33:  // Page Up
        viewer.prevStep();
        break;
      case 36:  // Home
        viewer.skipToFirstPage();
        break;
      case 35:  // End
        viewer.skipToLastPage();
        break;
      }
    });

    window.addEventListener('click', (e) => {
      if (e.button != 0) { return; }
      let viewer = Libretto.viewer();
      viewer.nextStep();
    });
  }
}

Libretto.IO = new IO();
