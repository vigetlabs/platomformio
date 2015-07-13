# TODO: - Save on build/upload
#       - get pretty output in a closeable modal or something

PlatomformioView        = require './platomformio-view'
{CompositeDisposable} = require 'atom'
process               = require 'child_process'

module.exports = Platomformio =
  platomformioView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @platomformioView = new PlatomformioView(state.platomformioViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @platomformioView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', "platomformio:toggle": => @toggle()

    @subscriptions.add atom.commands.add 'atom-workspace', "platomformio:build":  => @build()
    @subscriptions.add atom.commands.add 'atom-workspace', 'platomformio:upload': => @upload()
    @subscriptions.add atom.commands.add 'atom-workspace', 'platomformio:console': => @console()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @platomformioView.destroy()

  toggle: ->
    console.log 'AsciiArt was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  build: ->
    @saveWorkspace()
    proc = process.spawn("/usr/local/bin/platformio", ["run"], {cwd: @projectDir()})
    @logProcess(proc);

  upload: ->
    @saveWorkspace()
    proc = process.spawn("/usr/local/bin/platformio", ["run", "--target=upload"], {cwd: @projectDir()})
    @logProcess(proc);

  console: ->
    proc = process.spawn("/usr/local/bin/platformio", ["serialports", "monitor", "--baud=115200", "--echo"], {cwd: @projectDir()})
    @logProcess(proc);

  projectDir: ->
    editor = atom.workspace.getActivePaneItem()
    file = editor.buffer.file
    file.getParent().getParent().path

  saveWorkspace: ->
    paneItem = atom.workspace.getActivePaneItem()
    paneItem.save()

  logProcess: (proc) ->
    proc.stdout.on 'data', (data) ->
      console.log("" + data)
    proc.stderr.on 'data', (data) ->
      console.log("" + data)
