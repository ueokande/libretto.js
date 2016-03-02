Libretto.Css = class {

  //
  // Create <style> element into tag with id and return Css object.
  //
  static create(id) {
    if (document.getElementById(id)) {
      throw new Error(`The element '#${id}' is existing.  The id was conflicted.`);
    }

    let style = document.createElement('style');
    style.appendChild(document.createTextNode(''));
    if (typeof id !== 'undefined') {
      style.id = id;
    }
    window.document.head.appendChild(style);

    let css = new Libretto.Css();
    css.style = style;
    return css;
  }

  //
  // Find <style> element which has id, and return Css object.
  // If no element is found, return null.
  //
  static findById(id) {
    let ele = document.getElementById(id);
    if (ele === null) {
      return null;
    }

    let css = new Libretto.Css();
    css.style = ele;
    return css;
  }

  //
  // Find <style> element which has id, and return Css object.
  // If no element is found, create <style> element and return Css object.
  //
  static findOrCreate(id) {
    let css = this.findById(id);
    if (css === null) {
      css = this.create(id);
    }
    return css;
  }

  //
  // Returns CSS rules.
  //
  rules() {
    if (this.style === null) { return null; }
    if (typeof this.style.sheet.cssRules !== 'undefined') {
      return this.style.sheet.cssRules;
    }
    return this.style.sheet.rules;
  }

  //
  // Remove a rule of index
  //
  removeRule(index) {
    if (typeof this.style.sheet.deleteRule !== 'undefined') {
      return this.style.sheet.deleteRule(index);
    }
    return this.style.sheet.removeRule(index);
  }

  //
  // Add rule for selector with styles.
  //
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

  //
  // Clear all rules
  //
  clearRules() {
    if (this.style === null) { return; }
    while (this.rules().length != 0) {
      this.removeRule(0);
    }
  }

  //
  // Remove <style> element
  //
  finalize() {
    if (this.style === null) { return; }
    window.document.head.removeChild(this.style);
    this.style = null;
  }
};
