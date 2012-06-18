vimconfig
=========

Checkout this repository into your home folder as the .vim folder. (Or check it out and rename it to .vim)

Vundle is installed using a submodule. After checking out the repo, run the following two commands to fetch the Vundle package:

    git submodule init
    git submodule update

On Windows the home folder is wherever the environmental variable %USERPROFILE% points, but if you manually set a %HOME% variable, it can live anywhere. This is handy for keeping unixy tool configurations out of your Windows user profile folder. It makes them more portable, too, since they're not mixed in with the Windows stuff.

Since VIM normally looks for its startup config in the root of the home folder rather than in the .vim file, create a .vimrc file in your home folder and enter the following one line into that file to direct it to load the .vimrc file from within the .vim folder:

    source ~/.vim/.vimrc

This lets us manage the main configuration with GIT.

You will need the Envy Code R font from http://damieng.com/creative/typography.

After starting gVIM for the first time, run :BundleInstall to load all of the plugins specified in the configuration. Then restart gVIM!
