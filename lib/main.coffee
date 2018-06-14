configSchema = require './config-schema'

CompositeDisposable = null

Controller = null

module.exports =
  config: configSchema

  activate: ->
    {CompositeDisposable} = require 'atom'
    @subscriptions = new CompositeDisposable

    @init()

    @registerCommands()

    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      @subscriptions.add editor.onDidSave () =>
        if atom.config.get('lilycompile.compileAfterSave') and \
            editor.buffer.file?.path
          if @controller.isLilypondFile(editor.buffer.file?.path)
            @controller.compile()

  deactivate: ->
    @subscriptions.dispose()
    @controller.deactivate()

  #
  # internal methods
  #

  init: ->
    Controller ?= require './controller'
    @controller = new Controller

  registerCommands: ->
    @subscriptions.add atom.commands.add 'atom-workspace'
    , 'lilycompile:compile': => @controller.compile()

  provideCompile: ->
    Controller ?= require './controller'
    @controller = new Controller
    return @controller
