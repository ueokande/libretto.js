Libretto.pageEffects = {};

Libretto.registerPageEffect = (name, animation) => {
  Libretto.pageEffects[name.toLowerCase()] = animation;
};

Libretto.loadPageEffect = (name) => {
  name = name.toLowerCase();
  if (!Libretto.pageEffects.hasOwnProperty(name)) return null;
  return Libretto.pageEffects[name];
};
