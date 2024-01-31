#parser

This project was written by Dan Hawker in December 2023. Its purpose is to lex an ocaml proof and sort it into an abstract syntax tree, and then print it back in the same format.
The main.ml and sample.ml files were written by Sebastiaan Joosten, University of Minnesota, to help test and run the code

How to run:
- Have the dune project management system installed on your computer
- From the 'ocaml-parser' directory, run the command 'dune build'
- Run the executable with the provided sample file, or other files using the same syntax, using the following command:
    './_build/default/beastmode_on/bin/main.exe --printback sample.ml'
