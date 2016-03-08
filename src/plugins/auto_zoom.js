Libretto.AutoZoom = class extends Libretto.Plugin {
  initialize() {
    let computerBodyStyle = window.getComputedStyle(window.document.body);
    this.initialBodyWidth = computerBodyStyle.width.split('px')[0];
    this.initialBodyHeight = computerBodyStyle.height.split('px')[0];
    window.addEventListener('resize', () => {
      Libretto.AutoZoom.prototype.fitToWindow.call(this);
    });
    Libretto.AutoZoom.prototype.fitToWindow.call(this);
  }

  fitToWindow() {
    let iw = window.innerWidth;
    let ih = window.innerHeight;
    let zoom = Math.min(iw / this.initialBodyWidth, ih / this.initialBodyHeight);
    window.document.body.style.transform = `scale(${zoom}) translate(-50%, -50%)`;
  }
};

new Libretto.AutoZoom();
