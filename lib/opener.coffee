{CompositeDisposable} = require 'atom'

module.exports =
  class Opener
    constructor: ->
      @subscriptions = new CompositeDisposable

      @handleConfig()

    deactivate: ->
      @subscriptions.dispose()

    open: (result) ->
      if @config.openConfig is 'not at all'
        return

      panes = atom.workspace.getPanes()
      activePane = atom.workspace.getActivePane()

      if @config.openInBackground
        # check whether the file is already opened
        alreadyOpened = false

        for pane in panes
          if pane.itemForURI(result.outputName)?
            alreadyOpened = true

        if not alreadyOpened
          # only open file if was not open yet
          @openFile result.outputName
      else
        # opens the file, or switches to it if already open
        @openFile result.outputName

    #
    # internal methods
    #

    openFile: (uri) ->
      options =
        activatePane: @config.activateFilePane
        searchAllPanes: true

      if @config.openConfig is 'new tab'
        options.searchAllPanes = false

      currentPane = atom.workspace.getActivePane()

      atom.workspace.open uri, options
      .then (result) =>
        if (not (@config.openConfig is 'new tab')) and
        (currentPane is atom.workspace.paneForURI(uri))
          switch @config.openConfig
            when 'split up'
              currentPane.moveItemToPane currentPane.getActiveItem(),
              currentPane.splitUp(), 0
            when 'split down'
              currentPane.moveItemToPane currentPane.getActiveItem(),
              currentPane.splitDown(), 0
            when 'split right'
              currentPane.moveItemToPane currentPane.getActiveItem(),
              currentPane.splitRight(), 0
            when 'split left'
              currentPane.moveItemToPane currentPane.getActiveItem(),
              currentPane.splitLeft(), 0

    handleConfig: ->
      @config =
        pdf: {}
        png: {}
        svg: {}

      @subscriptions.add atom.config.observe 'lilycompile.openConfig',
      (newValue) =>
        @config.openConfig = newValue

      @subscriptions.add atom.config.observe 'lilycompile.openInBackground',
      (newValue) =>
        @config.openInBackground = newValue

      @subscriptions.add atom.config.observe 'lilycompile.activateFilePane',
      (newValue) =>
        @config.activateFilePane = newValue
