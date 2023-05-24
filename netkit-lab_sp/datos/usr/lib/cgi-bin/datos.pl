#!/usr/bin/perl -wT
use strict;

print "Content-type: text/html\n\n";
my $now = localtime;

print <<END_HTML;
<html>
  <body>
    <p>Hora de acceso: $now</p>
    <p>Accedido desde IP: $ENV{REMOTE_ADDR} puerto: $ENV{REMOTE_PORT}</p>
    <p>Hostname solicitado: $ENV{HTTP_HOST}</p>
    <p>Referenciado desde: $ENV{HTTP_REFERER}</p>
  </body>
</html>
END_HTML

