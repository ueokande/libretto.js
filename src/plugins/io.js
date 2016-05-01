export default class IO {
  constructor(target) {
    target.addEventListener('keypress', (e) => {
      let viewer = Libretto.viewer();
      if (e.charCode == '['.charCodeAt(0)) {
        viewer.skipPrev();
      } else if (e.charCode == ']'.charCodeAt(0)) {
        viewer.skipNext();
      }
    });

    target.addEventListener('keydown', (e) => {
      // TODO: Added Enter key but the Enter is conflicted to pager plugin.
      let viewer = Libretto.viewer();
      switch (e.keyCode) {
      // case 13:    // Enter
      case 32:  // Space
      case 40:  // Arrow Down
      case 34:  // Page Down
        viewer.step();
        break;
      case 38:  // Arrow up
      case 33:  // Page Up
        viewer.skipPrev();
        break;
      case 36:  // Home
        viewer.skipTo(0);
        break;
      case 35:  // End
        viewer.skipTo(Number.MAX_VALUE);
        break;
      }
    });

    target.addEventListener('click', (e) => {
      if (e.button != 0) { return; }
      let viewer = Libretto.viewer();
      viewer.step();
    });
  }
}
