use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use HTML::Entities;

$VERSION = "0.1";
%IRSSI = (name => 'notify.pl', license => 'GNU General Public License');

Irssi::settings_add_str('notify', 'notify_remote', '');
Irssi::settings_add_str('notify', 'notify_debug', '');

sub sanitize {
  my ($text) = @_;
  encode_entities($text,'\'<>&');
  my $apos = "&#39;";
  my $aposenc = "\&apos;";
  $text =~ s/$apos/$aposenc/g;
  $text =~ s/"/\\"/g;
  $text =~ s/\$/\\\$/g;
  $text =~ s/`/\\"/g;
  return $text;
}

sub notify {
  my ($server, $summary, $message) = @_;

  # Make the message entity-safe
  $summary = sanitize($summary);
  $message = sanitize($message);

  # pass it to libnotify
  my $cmd = "/usr/bin/notify-send ".
    "--urgency=low ".
    "--expire-time=0 ".
    "--app-name=irssi ".
    "--icon /usr/share/irssi/icons/irssi-icon.png ".
    "\"$summary\" \"$message\"";
  system($cmd);
}

sub print_text_notify {
  my ($dest, $text, $stripped) = @_;
  my $server = $dest->{server};

  return if (!$server || !($dest->{level} & MSGLEVEL_HILIGHT));
  my $sender = $stripped;
  $sender =~ s/^\<.([^\>]+)\>.+/\1/ ;
  $stripped =~ s/^\<.[^\>]+\>.// ;
  my $summary = $dest->{target} . ": " . $sender;
  notify($server, $summary, $stripped);
}

sub message_private_notify {
  my ($server, $msg, $nick, $address) = @_;

  return if (!$server);
  notify($server, "PM from ".$nick, $msg);
}

sub dcc_request_notify {
  my ($dcc, $sendaddr) = @_;
  my $server = $dcc->{server};

  return if (!$dcc);
  notify($server, "DCC ".$dcc->{type}." request", $dcc->{nick});
}

Irssi::signal_add('print text', 'print_text_notify');
Irssi::signal_add('message private', 'message_private_notify');
Irssi::signal_add('dcc request', 'dcc_request_notify');

