PlatomformioView      = require './platomformio-view'
{CompositeDisposable} = require 'atom'

module.exports = Platomformio =
  subscriptions: null

  activate: (state) ->
    @platomformioView = new PlatomformioView state.platomformioViewState

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'core:cancel'               : => @close()
      'platomformio:build'        : => @build()
      'platomformio:upload'       : => @upload()
      'platomformio:close'        : => @close()
      'platomformio:kill-process' : => @kill()


  deactivate: ->
    @platomformioView.close()

  serialize: ->
    platomformioViewState: @platomformioView.serialize()

  build: ->
    @saveWorkspace()

    @platomformioView.resetView("Building...")
    @platomformioView.run("/usr/local/bin/platformio", ["run"])

  upload: ->
    @saveWorkspace()

    @platomformioView.resetView("Uploading...")
    @platomformioView.panel.addClass("descriptive")
    @platomformioView.run("/usr/local/bin/platformio", ["run", "--target=upload"])

  close: ->
    @platomformioView.close()

  kill: ->
    @platomformioView.kill()

  saveWorkspace: ->
    paneItem = atom.workspace.getActivePaneItem()
    paneItem.save()
