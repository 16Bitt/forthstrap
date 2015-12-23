C ABI For Hosted Environments
-----------------------------

_What it is_

The C ABI for forthstrap is a way interfacing C code and libraries from within the forthstrap environment. This prevents writing lots of messy API calls by hand in assembler and shrinks the size of the codebase. For an example of this, see `arch/unix/gfx.c` in which the X11 server is easily interfaced.

_How it works_

The script that does the heavy lifting is `bin/c-generate.rb`. This script takes C files in and outputs a large chunk of assembler, which is written in the forthstrap assembly macro language.

_Example_

Let's say that you want to fork execution without writing the syscall by hand. This is easily accomplished:

```
/* Will automatically create a word named c_fork with 0 inputs and 0 outputs */

//F fork c_fork
```

Note that as long as the function exists and you've properly defined it, you don't need to write function wrappers, you just need to tell the script that you want to make the stub.

_What's missing or not working_

As of right now, the example code is 32-bit only, and I've only written the header for Linux on i686. On top of this, there can only be one or no values returned from a function in C. The word's name must also adhere to the rules for naming C variables.


