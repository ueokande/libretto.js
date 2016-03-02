Libretto.Css = class {
  static create(id) {
    let css = new Libretto.Css();
    let style = document.createElement('style');
    style.appendChild(document.createTextNode(''));
    if (typeof id !== 'undefined') { style.id = id; }
    window.document.head.appendChild(style);
    css.style = style;
    return css;
  }

  static findById(id) {
    let ele = document.getElementById(id);
    if (ele === null) { return null; }

    if (!(/style/i).test(ele.tagName)) {
      console.error(`The element '#${id}' is existing.  The id was conflicted.`);
      return null;
    }
    let css = new Libretto.Css();
    css.style = ele;
    return css;
  }

  static findOrCreate(id) {
    let ele = document.getElementById(id);
    if (ele === null) { return Libretto.Css.create(id); }

    if (!(/style/i).test(ele.tagName)) {
      console.error(`The element '#${id}' is existing.  The id was conflicted.`);
      return null;
    }
    let css = new Libretto.Css();
    css.style = ele;
    return css;
  }

  rules() {
    if (this.style === null) { return null; }
    if (typeof this.style.sheet.cssRules !== 'undefined') {
      return this.style.sheet.cssRules;
    }
    return this.style.sheet.rules;
  }

  removeRule(index) {
    if (typeof this.style.sheet.deleteRule !== 'undefined') {
      return this.style.sheet.deleteRule(0);
    }
    return this.style.sheet.removeRule(0);
  }

  addRule(selector, styles) {
    if (this.style === null) { return null; }
    let len = this.rules().length;
    if (typeof styles === 'undefined') {
      let cssString = `${selector} {}`;
      this.style.sheet.insertRule(cssString, len);
      return this.rules()[len].style;
    } else {
      let cssString = `${selector} {`;
      for (let key in styles) {
        cssString += `${key}: ${styles[key]} !important;`;
      }
      cssString += '}';
      return this.style.sheet.insertRule(cssString, len);
    }
  }

  clearRules() {
    if (this.style === null) { return; }
    while (this.rules().length != 0) {
      this.removeRule(0);
    }
  }

  finalize() {
    if (this.style === null) { return; }
    window.document.head.removeChild(this.style);
    this.style = null;
  }
};
