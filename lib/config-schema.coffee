module.exports =
  openConfig:
    title: 'Opening Behavior'
    description: 'How atom should open the generated file.'
    type: 'string'
    default: 'split right'
    enum: [
      'not at all'
      'new tab'
      'split up'
      'split down'
      'split right'
      'split left'
    ]
  openInBackground:
    title: 'Keep In Background'
    description: 'If the file is already open and this is true,
    atom will not switch to show it.'
    type: 'boolean'
    default: false
  activateFilePane:
    description: 'Whether the pane with the output file should be activated,
    or only shown.'
    type: 'boolean'
    default: true
  compileAfterSave:
    title: 'Compile Lilypond after saving'
    description: 'Run `lilycompile:compile` after saving a `.ly` file.'
    type: 'boolean'
    default: true
  outputPath:
    description: 'This is where the generated files are placed.
    Relative to the directory where the .ly file is located.'
    type: 'string'
    default: 'tmp'
  binary:
    type: 'string'
    description: 'The name of the program that gets executed by the plugin.
    If the plugin [does not work at all](https://github.com/AljoschaMeyer/atom-lilycompile/issues/1), try pasting the value of this option into a terminal and press enter. If that results in an error message, then you need to properly install lilypond itself, or if it is already installed, point the plugin to the correct executable.'
    default: 'lilypond'
  customArguments:
    type: 'string'
    description: 'Any [command line arguments](http://lilypond.org/doc/v2.18/Documentation/usage/command_002dline-usage.en.html) placed here are used by the plugin when invoking the lilypond binary. This allows you to do anything for which this plugin does not provide a custom option. For example, setting this to `-dresolution=300` would increase the resolution of png output.'
    default: ''
  useCustomArgumentsOnly:
    description: 'Activate this to prevent conflicts between custom arguments
    and the config generated ones.
    Just paste all arguments you want to the customArguments.'
    type: 'boolean'
    default: false
  fileType:
    description: 'Which type of file lilypond should generate from the .ly file.
     Atom does not include a pdf viewer package by default.
     It does handle png out of the box though.'
    type: 'string'
    default: 'pdf'
    enum: [
      'pdf'
      'png'
      'ps'
      'svg'
    ]
  pdfSettings:
    title: 'PDF Settings'
    description: 'If fileType is pdf, these settings apply.'
    type: 'object'
    properties:
      pointAndClick:
        description: 'Generate point-and-click links in the pdf file.
        They will not automatically work in atom.'
        type: 'boolean'
        default: false
  pngSettings:
    title: 'PNG Settings'
    description: 'If fileType is png, these settings apply.'
    type: 'object'
    properties:
      transparent:
        description: 'Background of the png becomes transparent.
        Inplemented by passing -dpixmap-format=pngalpha'
        type: 'boolean'
        default: false
