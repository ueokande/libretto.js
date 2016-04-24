Libretto.Plugin = class {
  constructor() {
    let that = this;
    window.addEventListener('load', () => {
      that.initialize().call(that);
    });
  }

  initialize() {
  }
};
