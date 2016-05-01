export default class IO {
  constructor(target) {
    target.addEventListener('keypress', (e) => {
      let nucleus = Libretto.nucleus();
      if (e.charCode == '['.charCodeAt(0)) {
        nucleus.skipPrev();
      } else if (e.charCode == ']'.charCodeAt(0)) {
        nucleus.skipNext();
      }
    });

    target.addEventListener('keydown', (e) => {
      // TODO: Added Enter key but the Enter is conflicted to pager plugin.
      let nucleus = Libretto.nucleus();
      switch (e.keyCode) {
      // case 13:    // Enter
      case 32:  // Space
      case 40:  // Arrow Down
      case 34:  // Page Down
        nucleus.step();
        break;
      case 38:  // Arrow up
      case 33:  // Page Up
        nucleus.skipPrev();
        break;
      case 36:  // Home
        nucleus.skipTo(0);
        break;
      case 35:  // End
        nucleus.skipTo(Number.MAX_VALUE);
        break;
      }
    });

    target.addEventListener('click', (e) => {
      if (e.button != 0) { return; }
      let nucleus = Libretto.nucleus();
      nucleus.step();
    });
  }
}
