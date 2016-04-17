export default class Plugin {
  constructor() {
    let that = this;
    window.addEventListener('load', () => {
      that.initialize();
    });
  }

  initialize() {
  }
}
