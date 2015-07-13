Emacs
=====

[Emacs][1] is the highly-customizable
editor written initially for the GNU/Linux operating system, and now
available to many other platforms. 

Emacs is my editor of choice because I can customize it the way I want,
thanks to the Emacs Lisp, a dialect from the Lisp language.

Many programs like LaTeX, R, and the Linux shell can be run inside
Emacs, and make use of all of its power. You can even make [coffee with
Emacs](http://www.emacswiki.org/emacs/CoffeeMode)!!!

This repository contains a `.emacs` written in Emacs Lisp, with all the
configuration I use. More information can be found in the comments
inside it.

> **NOTE**: I renamed `.emacs` to `emacs.el` to get syntax highlighting
>  from github. If you would like to use this file you should really do
  
>         ~$ mv emacs.el .emacs
	 
>  in your `HOME` directory.

The file `functions.el` contain several defined functions for various
modes of emacs. This file must be in `~/.emacs.d/functions.el`, and it
is loaded inside `.emacs` with

```shell
(load "~/.emacs.d/functions")
```

Many things here are shared with the repo of
[Walmes Zeviani](https://github.com/walmes/emacs) who have many other
features.

[1]: http://www.gnu.org/software/emacs "Emacs"
