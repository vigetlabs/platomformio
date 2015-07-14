{CompositeDisposable} = require 'atom'
process               = require 'child_process'

module.exports = Platomformio =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', "platomformio:build":  => @build()
    @subscriptions.add atom.commands.add 'atom-workspace', 'platomformio:upload': => @upload()

  deactivate: ->
    @subscriptions.dispose()

  build: ->
    @saveWorkspace()
    proc = process.spawn("/usr/local/bin/platformio", ["run"], {cwd: @projectDir()})
    @logProcess(proc);

  upload: ->
    @saveWorkspace()
    proc = process.spawn("/usr/local/bin/platformio", ["run", "--target=upload"], {cwd: @projectDir()})
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
