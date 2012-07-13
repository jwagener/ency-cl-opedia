RWP.registerPlugin "Test", ->
  console.log("test plugin registered")

  RWP.bind"articleLoaded", (e) ->
    console.log(" test art loaded", e)