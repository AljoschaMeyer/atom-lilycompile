Lilypond = require './lilypond'
Opener = require './opener'

module.exports =
  class Controller
    constructor: ->
      @lily = new Lilypond
      @fileOpener = new Opener

    empty_path = null
    compile: (path = empty_path) ->

      if path
        compilePath = path
      else
        editorDetails = @getEditorDetails()

        unless editorDetails.filePath?
          atom.notifications.addError 'Can only compile .ly files.', dismissable: true
          return

        unless @isLilypondFile editorDetails.filePath
          atom.notifications.addError 'Can only compile .ly files.', dismissable: true
          return

        editorDetails.editor.save() if editorDetails.editor.isModified()

        compilePath = editorDetails.filePath

      @lily.compile compilePath
      .then (result) =>
        @fileOpener.open(result)
        return Promise.resolve()
      , (error) ->
        return Promise.reject(error)

    deactivate: ->
      @subscriptions.dispose()
      @lily.deactivate()
      @fileOpener.deactivate()

    #
    # internal methods
    #

    getEditorDetails: ->
      editor = atom.workspace.getActiveTextEditor()

      if editor?
        filePath = editor.getPath()

      return {
        editor: editor
        filePath: filePath
      }

    isLilypondFile: (filePath) ->
      return (not filePath?) or (filePath.search(/\.ly$/) > 0)
