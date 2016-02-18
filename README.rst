===============
What is this?
===============

**bm** is a POSIX compliant bookmarking system for shell.  It can be
used to create new bookmarks pointing to a directory, switching to a
speciefied bookmarks and removing existing bookmarks. It comes with a
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

See included **man** for details.
