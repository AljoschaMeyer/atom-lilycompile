{CompositeDisposable} = require 'atom'
child_process = require 'child_process'
path = require 'path'
fs = require 'fs'
mkdirp = require 'mkdirp'

module.exports =
  class Lilypond
    constructor: ->
      @subscriptions = new CompositeDisposable

      @handleConfig()

    deactivate: ->
      @subscriptions.dispose()

    compile: (filePath) ->
      args = @constructArguments filePath
      command = "#{@config.binary} #{args.join ' '}"
      options = @constructOptions filePath

      console.log command

      outputName = @determineOutputName filePath

      return new Promise (resolve, reject) ->
        child_process.exec command, options, (error, stdout, stderr) ->
          if error?
            atom.notifications.addError 'Lilypond Compilation Error', dismissable: true, detail: stderr
            reject error
          else
            result =
              outputName: outputName

            resolve result

    #
    # internal methods
    #

    constructArguments: (filePath) ->
      args = []

      unless @config.useCustomArgumentsOnly
        args.push "-f#{@config.fileType}"
        args.push "-o \"#{@determineOutputLocation path.dirname filePath}\""

        switch @config.fileType
          when 'pdf'
            args.push '-dno-point-and-click' unless @config.pdf.pointAndClick
          when 'png'
            if @config.png.transparent
              args.push '-dpixmap-format=pngalpha'

      args.push @config.customArguments
      args.push "\"#{filePath}\""

      return args

    constructOptions: (filePath) ->
      options =
        cwd: path.dirname filePath

      return options

    determineOutputLocation: (currentDirectory) ->
      stats = null

      if path.isAbsolute @config.outputPath
        location = @config.outputPath
      else
        location = "#{currentDirectory}/#{@config.outputPath}"

      try
        stats = fs.lstatSync location
      # file does not exists
      catch error
        mkdirp.sync location

      if stats? and not stats.isDirectory()
        atom.notifications.addError "Can not output files to #{location},
        path already exists and is not a directory.", dismissable: true
        throw new Error "Can not output files to #{location},
        path already exists and is not a directory."

      return location

    determineOutputName: (filePath) ->
      if path.isAbsolute @config.outputPath
        return path.normalize "#{@config.outputPath}/\
        #{path.basename filePath, '.ly'}.#{@config.fileType}"
      else
        return path.normalize "#{path.dirname filePath}/\
        #{@config.outputPath}/\
        #{path.basename filePath, '.ly'}.#{@config.fileType}"

    handleConfig: ->
      @config =
        pdf: {}
        png: {}
        ps: {}

      @subscriptions.add atom.config.observe 'lilycompile.outputPath',
      (newValue) =>
        @config.outputPath = newValue

      @subscriptions.add atom.config.observe 'lilycompile.fileType',
      (newValue) =>
        @config.fileType = newValue

      @subscriptions.add atom.config.observe 'lilycompile.binary',
      (newValue) =>
        @config.binary = newValue

      @subscriptions.add atom.config.observe 'lilycompile.customArguments',
      (newValue) =>
        @config.customArguments = newValue

      @subscriptions.add atom.config.observe(
        'lilycompile.useCustomArgumentsOnly', (newValue) =>
          @config.useCustomArgumentsOnly = newValue
      )

      @subscriptions.add atom.config.observe(
        'lilycompile.pdfSettings.pointAndClick', (newValue) =>
          @config.pdf.pointAndClick = newValue
      )

      @subscriptions.add atom.config.observe(
        'lilycompile.pngSettings.transparent', (newValue) =>
          @config.png.transparent = newValue
      )
