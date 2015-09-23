Lilypond = require './lilypond'
Opener = require './opener'

module.exports =
  class Controller
    constructor: ->
      @lily = new Lilypond
      @fileOpener = new Opener

    compile: ->
      editorDetails = @getEditorDetails()

      unless editorDetails.filePath?
        return Promise.reject Error 'Can\'t compile a file not saved to disk.'

      unless @isLilypondFile editorDetails.filePath
        return Promise.reject Error 'Can only compile .ly files.'

      editorDetails.editor.save() if editorDetails.editor.isModified()

      @lily.compile editorDetails.filePath
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
