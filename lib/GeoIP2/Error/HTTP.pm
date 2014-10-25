package GeoIP2::Error::HTTP;
{
  $GeoIP2::Error::HTTP::VERSION = '0.0200';
}

use strict;
use warnings;

use GeoIP2::Types qw( Str );

use Moo;

with 'GeoIP2::Role::Error::HTTP';

extends 'Throwable::Error';

1;

# ABSTRACT: An HTTP transport error

__END__

=pod

=head1 NAME

GeoIP2::Error::HTTP - An HTTP transport error

=head1 VERSION

version 0.0200

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;
  use Scalar::Util qw( blessed );

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
          log_http_error(
              status => $_->http_status(),
              uri    => $_->uri(),
          );
      }

      # handle other exceptions
  };

=head1 DESCRIPTION

This class represents an HTTP transport error. It extends L<Throwable::Error>
and adds attributes of its own.

=head1 METHODS

The C<< $error->message() >>, and C<< $error->stack_trace() >> methods are
inherited from L<Throwable::Error>. It also provide two methods of its own:

=head2 $error->http_status()

Returns the HTTP status. This should be either a 4xx or 5xx error.

=head2 $error->uri()

Returns the URI which gave the HTTP error.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
