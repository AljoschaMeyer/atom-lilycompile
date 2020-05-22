# Lilycompile

### This code is not maintained anymore

Compile .ly files and view the output - directly within atom.

Comes with one configurable command, lilycompile:compile (ctrl-alt-l), which only triggers in .ly files. Needs the [AtLilyPond](https://atom.io/packages/AtLilyPond) package to recognize .ly files by their grammar.

To open pdf files in atom, you need to install a pdf viewer package. Or you can change the output to png, which atom can handle by default.

This is only intended to generate previews, not to automate building processes.

Code structure and features borrowed from and inspired by the atom-latex package.

## Features
- compile .ly files to pdf, png, svg or ps
- configurable output folder location
- pass custom cli options to lilypad
- configurable file opening behavior
  - open in new tab, split pane, or don't open at all
  - switch to output if already opened (may be turned off)
- convenient cli option configs:
  - activate/deactivate point and click links in pdf
  - activate/deactivate transparent background for png
