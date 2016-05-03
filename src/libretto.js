// To support ES6 classes
require('babel-polyfill');

import Nucleus from './nucleus';
import Viewer from './viewer';
import * as PageEffect from './page_effect';
import Plugin from './plugin';

let nucleusInstance = new Nucleus();
window.Libretto = {
  registerPageEffect: PageEffect.registerPageEffect,
  loadPageEffect: PageEffect.loadPageEffect,
  Plugin,
  nucleus: () => nucleusInstance
};

new Viewer();

// Load plugins
require('./plugins/2d-animations');
require('./plugins/auto_zoom.js');
require('./plugins/location.js');
