vimconfig
=========

Checkout this repository into your $HOME/%HOME% folder as `vimfiles`.

The Hack font is used: https://sourcefoundry.org/hack/

On Windows the home folder is wherever the environmental variable %USERPROFILE% points, but if you manually set a %HOME% variable, it can live anywhere. This is handy for keeping unixy tool configurations out of your Windows user profile folder. It makes them more portable, too, since they're not mixed in with the Windows stuff.

This lets us manage the main configuration with GIT.

After starting gVIM for the first time, run :PlugInstall to load all of the plugins specified in the configuration. Then restart gVIM!

Remember that `:help nbf` brings up a handy custom cheatsheet!
