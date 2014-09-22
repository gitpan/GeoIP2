package GeoIP2::Model::ConnectionType;
$GeoIP2::Model::ConnectionType::VERSION = '2.000000';
use strict;
use warnings;

use GeoIP2::Types qw( IPAddress Str );

use Moo;

with 'GeoIP2::Role::Model::Flat', 'GeoIP2::Role::HasIPAddress';

has connection_type => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_connection_type',
);

1;

# ABSTRACT: Model class for the GeoIP2 Connection Type database

__END__

=pod

=head1 NAME

GeoIP2::Model::ConnectionType - Model class for the GeoIP2 Connection Type database

=head1 VERSION

version 2.000000

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::Model::ConnectionType;

  my $record = GeoIP2::Model::ConnectionType->new(
      raw => { connection_type => 'Corporate', ip_address => '24.24.24.24'}
  );

  say $record->connection_type();

=head1 DESCRIPTION

This class provides a model for GeoIP2 Connection-Type.

=head1 METHODS

This class provides the following methods:

=head2 $record->connection_type()

Returns the connection type as a string.

=head2 $record->ip_address()

Returns the IP address used in the lookup.

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
