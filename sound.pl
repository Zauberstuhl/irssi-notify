use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '0.0.1';
%IRSSI = (
  authors => 'Lukas Matt',
  contact => 'lukas@zauberstuhl.de',
  name => 'alert',
  description => 'Play sounds for different events in IRSSI.',
  url => 'http://github.com/zauberstuhl',
  license => 'GNU General Public License',
  changed => '$Date: 2015-01-15 00:08:00 +0100 (Sat, 15 Jan 2015) $'
);

sub pub_msg {
  my ($server,$msg,$nick,$address,$target) = @_;
  system("/usr/bin/playsound --volume 0.1 /home/lukas/Music/notifications/info.mp3 > /dev/null 2>&1 &");
}

sub pri_msg {
  my ($server,$msg,$nick,$address,$target) = @_;
  system("/usr/bin/playsound --volume 0.1 /home/lukas/Music/notifications/info.mp3 > /dev/null 2>&1 &");
}

sub nick_msg {
  my ($server,$msg,$nick,$address,$target) = @_;
  system("/usr/bin/playsound --volume 0.1 /home/lukas/Music/notifications/error.mp3 > /dev/null 2>&1 &");
}

Irssi::signal_add("beep", "nick_msg");
#Irssi::signal_add_last("message public", "pub_msg");
#Irssi::signal_add_last("message private", "pri_msg");
