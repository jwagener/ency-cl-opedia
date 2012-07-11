window.RWP =
  plugins: {}
  registerPlugin: (name, fn) ->
    RWP.plugins[name] = fn