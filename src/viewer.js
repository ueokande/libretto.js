import PageTransition from './page_transition';
import Css from './css';
import IO from './plugins/io';

export default class Viewer {

  //
  // Initializes internal variables and HTML contents.
  //
  constructor() {
    this.animationCss = null;
    this.pageTransition = null;

    new IO(window);

    let nucleus = Libretto.nucleus();
    nucleus.addEventListener('page.transit', (e) => {
      if (this.pageTransition !== null) {
        this.pageTransition.finalize();
      }
      let from = e.detail.from;
      let to = e.detail.to;
      this.pageTransition = new PageTransition(from, to);
      this.pageTransition.switchPage(true);
    });

    nucleus.addEventListener('page.skip', (e) => {
      if (this.pageTransition !== null) {
        this.pageTransition.finalize();
      }
      let from = e.detail.from;
      let to = e.detail.to;
      this.pageTransition = new PageTransition(from, to);
      this.pageTransition.switchPage(false);
    });

    nucleus.addEventListener('page.changed', (e) => {
      let index = e.detail.to;
      this.animationCss = Css.findOrCreate(`animation-${index}`);
      this.animationCss.clearRules();
    });

    nucleus.addEventListener('keyframe.play', (e) => {
      let target = e.detail.target;
      let properties = e.detail.properties;
      this.animationCss.addRule(target, properties);
    });
  }
}
