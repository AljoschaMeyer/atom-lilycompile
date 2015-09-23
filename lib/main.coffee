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
