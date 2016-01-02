PlatomformioView      = require './platomformio-view'
{CompositeDisposable} = require 'atom'

module.exports = Platomformio =
  config:
    verboseBuild:
      title: 'Show all build output (default is to only show if an error occurs)'
      type: 'boolean'
      default: false
    verboseUpload:
      title: 'Show all upload output (default is to only show if an error occurs)'
      type: 'boolean'
      default: true
    environPath:
      title: 'Environment PATH to run `platformio`'
      description: 'Paste here the result of `echo $PATH` (Unix) / `echo %PATH%` (Windows) command by typing into your terminal'
      type: 'string'
      default: process.env.PATH
  subscriptions: null

  activate: (state) ->
    @platomformioView = new PlatomformioView state.platomformioViewState

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'core:cancel'               : => @close()
      'platomformio:build'        : => @build()
      'platomformio:upload'       : => @upload()
      'platomformio:program'      : => @program()
      'platomformio:uploadfs'     : => @uploadfs()
      'platomformio:clean'        : => @clean()
      'platomformio:close'        : => @close()
      'platomformio:kill-process' : => @kill()

  deactivate: ->
    @platomformioView.close()

  serialize: ->
    platomformioViewState: @platomformioView.serialize()

  build: ->
    @saveWorkspace()

    @platomformioView.resetView("Building...")
    if atom.config.get('platomformio.verboseBuild')
      @platomformioView.panel.addClass("descriptive")

    @platomformioView.run("platformio", ["-f", "-c", "atom", "run"])

  upload: ->
    @saveWorkspace()

    @platomformioView.resetView("Uploading...")
    if atom.config.get('platomformio.verboseUpload')
      @platomformioView.panel.addClass("descriptive")

    @platomformioView.run("platformio", ["-f", "-c", "atom", "run", "-t", "upload"])

  program: ->
    @saveWorkspace()

    @platomformioView.resetView("Uploading using Programmer...")
    if atom.config.get('platomformio.verboseUpload')
      @platomformioView.panel.addClass("descriptive")

    @platomformioView.run("platformio", ["-f", "-c", "atom", "run", "-t", "program"])

  uploadfs: ->
    @saveWorkspace()

    @platomformioView.resetView("Upload SPIFFS image...")
    if atom.config.get('platomformio.verboseUpload')
      @platomformioView.panel.addClass("descriptive")

    @platomformioView.run("platformio", ["-f", "-c", "atom", "run", "-t", "uploadfs"])

  clean: ->
    @saveWorkspace()

    @platomformioView.resetView("Cleaning...")
    if atom.config.get('platomformio.verboseUpload')
      @platomformioView.panel.addClass("descriptive")

    @platomformioView.run("platformio", ["-f", "-c", "atom", "run", "-t", "clean"])

  close: ->
    @platomformioView.close()

  kill: ->
    @platomformioView.kill()

  saveWorkspace: ->
    atom.workspace.getActiveTextEditor()?.save()
