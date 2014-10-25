package GeoIP2::Error::WebService;
{
  $GeoIP2::Error::WebService::VERSION = '0.0301';
}

use strict;
use warnings;

use GeoIP2::Types qw( Str );

use Moo;

with 'GeoIP2::Role::Error::HTTP';

extends 'Throwable::Error';

has code => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

1;

# ABSTRACT: An explicit error from the GeoIP2 web service

__END__

=pod

=head1 NAME

GeoIP2::Error::WebService - An explicit error from the GeoIP2 web service

=head1 VERSION

version 0.0301

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;
  use Scalar::Util qw( blessed );
  use Try::Tiny;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  try {
      $client->omni( ip => '24.24.24.24' );
  }
  catch {
      die $_ unless blessed $_;
      if ( $_->isa('GeoIP2::Error::HTTP') ) {
          log_web_service_error(
              maxmind_code => $_->code(),
              status       => $_->http_status(),
              uri          => $_->uri(),
          );
      }

      # handle other exceptions
  };

=head1 DESCRIPTION

This class represents an error returned by MaxMind's GeoIP2 web service. It
extends L<Throwable::Error> and adds attributes of its own.

=head1 METHODS

The C<< $error->message() >>, and C<< $error->stack_trace() >> methods are
inherited from L<Throwable::Error>. The message will be the value provided by
the MaxMind web service. See L<http://dev.maxmind.com/geoip/geoip2/web-services> for
details.

It also provides three methods of its own:

=head2 $error->code()

Returns the code returned by the MaxMind GeoIP2 web service.

=head2 $error->http_status()

Returns the HTTP status. This should be either a 4xx or 5xx error.

=head2 $error->uri()

Returns the URI which gave the HTTP error.

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <drolsky@maxmind.com>

=item *

Greg Oschwald <goschwald@maxmind.com>

=item *

Olaf Alders <oalders@maxmind.com>

=back

=head1 CONTRIBUTOR

Graham Knop <haarg@haarg.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
