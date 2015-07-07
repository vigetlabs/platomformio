# TODO: - Save on build/upload
#       - get pretty output in a closeable modal or something

PlatformioView        = require './platformio-view'
{CompositeDisposable} = require 'atom'
process               = require 'child_process'

module.exports = Platformio =
  platformioView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @platformioView = new PlatformioView(state.platformioViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @platformioView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', "platformio:toggle": => @toggle()

    @subscriptions.add atom.commands.add 'atom-workspace', "platformio:build":  => @build()
    @subscriptions.add atom.commands.add 'atom-workspace', 'platformio:upload': => @upload()
    @subscriptions.add atom.commands.add 'atom-workspace', 'platformio:console': => @console()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @platformioView.destroy()

  toggle: ->
    console.log 'AsciiArt was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  build: ->
    console.log "Trying to build your thing! Project Dir: " + @projectDir()
    proc = process.spawn("/usr/local/bin/platformio", ["run"], {cwd: @projectDir()})
    proc.stdout.on 'data', (data) ->
      console.log("" + data)
    proc.stderr.on 'data', (data) ->
      console.log("" + data)

  upload: ->
    console.log "Trying to upload your thing! Project Dir: " + @projectDir()
    proc = process.spawn("/usr/local/bin/platformio", ["run", "--target=upload"], {cwd: @projectDir()})
    proc.stdout.on 'data', (data) ->
      console.log("" + data)
    proc.stderr.on 'data', (data) ->
      console.log("" + data)

  console: ->
    console.log "Console logging your thing! Project Dir: " + @projectDir()
    proc = process.spawn("/usr/local/bin/platformio", ["serialports", "monitor", "--baud=115200", "--echo"], {cwd: @projectDir()})
    proc.stdout.on 'data', (data) ->
      console.log("" + data)
    proc.stderr.on 'data', (data) ->
      console.log("" + data)

  projectDir: ->
    editor = atom.workspace.getActivePaneItem()
    file = editor.buffer.file
    file.getParent().getParent().path
