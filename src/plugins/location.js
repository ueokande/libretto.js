class Location extends Libretto.Plugin {
  initialize() {
    window.addEventListener('hashchange', () => {
      Location.prototype.applyPage.call(this);
    });

    let viewer = Libretto.Viewer.viewer();
    viewer.addCurrentPageChangedListener(() => {
      let index = viewer.getCurrentIndex();
      Location.prototype.setHash.call(this, index);
    });

    Location.prototype.applyPage.call(this);
  }

  setHash(index) {
    window.location.hash = index + 1;
  }

  applyPage() {
    let num = Number(window.location.hash.split('#')[1]);
    if (isNaN(num)) { num = 1; }
    let viewer = Libretto.Viewer.viewer();
    viewer.skipToPage(num - 1);
  }
}

Libretto.Location = new Location();
