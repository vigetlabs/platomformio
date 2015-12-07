HeaderView        = require './header-view'
{BufferedProcess} = require 'atom'
{View, $$}        = require 'atom-space-pen-views'
AnsiFilter        = require 'ansi-to-html'


module.exports =
class PlatomformioView extends View
  @bufferedProcess: null
  @results: ""

  @content: ->
    @div =>
      @subview 'headerView', new HeaderView()

      # Display layout and outlets
      css = 'tool-panel panel panel-bottom padding platomformio-view
        native-key-bindings'
      @div class: css, outlet: 'panel', tabindex: -1, =>
        @div class: 'panel-body padded output', outlet: 'output'

  initialize: (serializeState) ->
    @ansiFilter = new AnsiFilter

  serialize: ->

  resetView: (title = 'Loading...') ->
    # Display window and load message
    @panel.removeClass "descriptive"

    # First run, create view
    atom.workspace.addBottomPanel(item: this) unless @hasParent()

    # Close any existing process and start a new one
    @kill()

    @headerView.title.text title
    @headerView.setStatus 'start'

    # Get script view ready
    @output.empty()

    # Remove the old script results
    @results = ""

  close: ->
    # Stop any running process and dismiss window
    @kill()
    if @hasParent()
      grandParent = @panel.parent().parent()
      @detach()
      grandParent.remove()

  run: (command, args) ->
    startTime = new Date()

    # Default to where the user opened atom
    options =
      cwd: @getCwd()
      env: process.env

    # override PATH with the user value
    if atom.config.get('platomformio.environPath')
      options.env.PATH = atom.config.get('platomformio.environPath') + ":" + options.env.PATH

    if options.cwd is undefined
      @output.append $$ ->
        @h1 "Unable to run command: \"#{command}\""
        @pre "Could not find a platformio.ini config file to identify the project"
    else
      stdout = (output) => @display 'stdout', output
      stderr = (output) => @display 'stderr', output
      exit = (returnCode) =>
        @bufferedProcess = null

        executionTime = (new Date().getTime() - startTime.getTime()) / 1000
        @display 'stdout', '[Finished in '+executionTime.toString()+'s]'

        if returnCode is 0
          @success()
        else
          @error()
        console.log "Exited with #{returnCode}"

      # Run process
      @bufferedProcess = new BufferedProcess({
        command, args, options, stdout, stderr, exit
      })

      @bufferedProcess.onWillThrowError (nodeError) =>
        @error()
        @bufferedProcess = null
        @output.append $$ ->
          @h1 "Unable to run command: \"#{command}\""
          @pre "ERROR: #{nodeError.error.message}"
          @pre "You might need to update your package's PATH setting"
          @pre "Current PATH: #{process.env.PATH}"

        console.log(nodeError)
        nodeError.handle()

  kill: ->
    @headerView.title.text 'Killed'

    # Kill existing process if available
    if @bufferedProcess?
      @display 'stdout', '^C'
      @headerView.setStatus 'kill'
      @bufferedProcess.kill()
      @bufferedProcess = null

  display: (css, line) ->
    @results += line

    line = @ansiFilter.toHtml(line)

    padding = parseInt(@output.css('padding-bottom'))
    scrolledToEnd =
      @panel.scrollBottom() == (padding + @output.trueHeight())

    lessThanFull = @output.trueHeight() <= @panel.trueHeight()

    @output.append $$ ->
      @pre class: "line #{css}", =>
        @raw line

    @panel.scrollTop(@output.trueHeight())

  getCwd: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor
    dir = editor.buffer.file.getParent()

    until dir.getFile('platformio.ini').existsSync()
      # File system root has been reached: prevent infinite loop
      return if lastDir?.getRealPathSync() is dir.getRealPathSync()
      [lastDir, dir] = [dir, dir.getParent()]

    dir.getRealPathSync()

  success: ->
    @headerView.title.text 'Success'
    @headerView.setStatus 'stop'

  error: ->
    @headerView.title.text 'Oh no...'
    @panel.addClass "descriptive"
    @headerView.setStatus 'err'
