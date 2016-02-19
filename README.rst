===============
What is this?
===============

**bm** is a POSIX compliant bookmarking system for shell.  It can be
used to create new bookmarks pointing to a directory, switching to a
specified bookmark and removing existing bookmarks. It comes with a
completion support for **Bash** and a manual in form of a **manpage**.

How to use it?
==============

In short:

::

   $ mkdir /tmp/test-dir/
   $ cd /tmp/test-dir/
   $ bm add first_bookmark
   $ bm ls
   /tmp/test-dir first_bookmark
   $ cd ~ja
   $ pwd
   /home/ja
   $ bm first_bookmark
   $ pwd
   /tmp/test-dir
   $ bm rm first_bookmark
   $ bm ls

See included **man** for description of all commands and exit codes.

Installation
============

Source **bm.sh** in your interactive shell startup file, for example
**$HOME/.bashrc** or **$HOME/.zshrc**. **bm** must be sourced before
use and not run as an external command because it uses **cd** command
which changes state of the *current* subshell and therefore must be
executed in current shell context.

Source **bm.bash-completion** in your **Bash** shell startup file or
copy it to */etc/bash_completion.d* for autocompletion of **bm**
commands and bookmarks names.
