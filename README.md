# Lilycompile

Compile .ly files and view the output - directly within atom.

Comes with one configurable command, lilycompile:compile (ctrl-alt-l), which only triggers in .ly files. Needs the [AtLilyPond](https://atom.io/packages/AtLilyPond) package to recognize .ly files by their grammar.

To open pdf files in atom, you need to install a pdf viewer package. Or you can change the output to png, which atom can handle by default.

This is only intended to generate previews, not to automate building processes.

Code structure and features borrowed from and inspired by the atom-latex package.

## Features
- [x] compile .ly files to pdf, png or ps
- [x] configurable output folder location
- [x] pass custom cli options to lilypad
- [x] configurable file opening behavior
  - [x] open in new tab, split pane, or don't open at all
  - [x] switch to output if already opened (may be turned off)
- [x] convenient cli option configs:
  - [x] activate/deactivate point and click links in pdf
  - [x] activate/deactivate transparent background for png

### TODO
Loosely sorted by priority. Which might coincide with difficulty of implementation.
- [ ] unit tests. I already feel bad for publishing this without them.
- [ ] take a look at the md-preview package for clean file opening
- [ ] svg support
- [ ] open output with custom command instead of atom
- [ ] Visual feedback on compilation
  - [ ] Show the executed command
  - [ ] Indicate progress, warnings, errors and success
  - [ ] Show log
  - [ ] 'syntax highlighting' for the log: color warnings and errors
  - [ ] open log file function, jump to first warning/error
- ...
- ...
- ...
- [ ] working point and click in atom
