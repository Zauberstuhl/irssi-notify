Dependencies
------------

    $ sudo aptitude install libnotify-bin

Installation
------------

    $ cp notify.pl ~/.irssi/scripts/
    $ mkdir -p ~/.irssi/scripts/autorun
    $ ln -s ~/.irssi/scripts/notify.pl ~/.irssi/scripts/autorun/

Now start irssi or if it is already running execute `/script load notify.pl`
