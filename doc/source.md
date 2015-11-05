Embedding Source Code for Runtime Compilation
---------------------------------------------


_Why_

You'll find that out of the box, forthstrap is very limited. It has a shell, but no comments, no strings, and no way to load any other code besides manually typing in all of your words. Forthstrap allows embedding source code in binaries as a recommended approach to automate the loading of critical components.


_How_


Forthstrap has some bizarre required words, one of which being ROM_ADDR. This variable is the address of string in RW data that can be loaded into memory at runtime. Most assemblers have a directive for embedding raw binary data into source, usually named `incbin`. Provided that ROM_ADDR returns the address of a zero delimited string that contains ASCII source and `payload.forth` is bootstrapped with your distribution, your code will be loaded. Note that you should manually insert spaces if there are multiple files to be safe and ensure the interpreter can read the code properly.


Runtime Loading of Code Without Embedding
-----------------------------------------


Assuming your target system has a working `file.forth` implementation, you should be able to easily add code to `init.forth` (make sure you embed `init.forth`, however). The file is intuitive and easily edited.
