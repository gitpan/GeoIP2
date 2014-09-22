package GeoIP2::Error::IPAddressNotFound;
$GeoIP2::Error::IPAddressNotFound::VERSION = '2.000001';
use strict;
use warnings;

use GeoIP2::Types qw( Str );

use Moo;

extends 'Throwable::Error';

has ip_address => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

1;

# ABSTRACT: An exception thrown when an IP address is not in the MaxMind GeoIP2 database

__END__

=pod

=head1 NAME

GeoIP2::Error::IPAddressNotFound - An exception thrown when an IP address is not in the MaxMind GeoIP2 database

=head1 VERSION

version 2.000001

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
      $client->insights( ip => '24.24.24.24' );
  }
  catch {
      die $_ unless blessed $_;
      if ( $_->isa('GeoIP2::Error::IPAddressNotFound') ) {
          log_ip_address_not_found_error( ip_address => $_->ip_address() );
      }

      # handle other exceptions
  };

=head1 DESCRIPTION

This class represents an error that occurs when an IP address is not found in
the MaxMind GeoIP2 database, either through a web service or a local database.

=head1 METHODS

The C<< $error->message() >>, and C<< $error->stack_trace() >> methods are
inherited from L<Throwable::Error>. It also provide two methods of its own:

=head2 $error->ip_address()

Returns the IP address that could not be found.

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <drolsky@maxmind.com>

=item *

Greg Oschwald <goschwald@maxmind.com>

=item *

Olaf Alders <oalders@maxmind.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
