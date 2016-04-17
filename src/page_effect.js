let pageEffects = {};

export function registerPageEffect(name, animation) {
  pageEffects[name.toLowerCase()] = animation;
}

export function loadPageEffect(name) {
  name = name.toLowerCase();
  if (!pageEffects.hasOwnProperty(name)) return null;
  return pageEffects[name];
}
