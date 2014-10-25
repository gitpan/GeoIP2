package GeoIP2::Record::Subdivision;
{
  $GeoIP2::Record::Subdivision::VERSION = '0.0200';
}

use strict;
use warnings;

use GeoIP2::Types qw( NonNegativeInt PositiveInt Str );

use Moo;

with 'GeoIP2::Role::Record::HasNames';

has confidence => (
    is        => 'ro',
    isa       => NonNegativeInt,
    predicate => 'has_confidence',
);

has geoname_id => (
    is       => 'ro',
    isa      => PositiveInt,
    predicate => 'has_geoname_id',
);

has iso_code => (
    is       => 'ro',
    isa      => Str,
    predicate => 'has_iso_code',
);

1;

# ABSTRACT: Contains data for the subdivision record associated with an IP address

__END__

=pod

=head1 NAME

GeoIP2::Record::Subdivision - Contains data for the subdivision record associated with an IP address

=head1 VERSION

version 0.0200

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  my $city = $client->city_isp_org( ip => '24.24.24.24' );

  my $subdivision_rec = $city->subdivision();
  say $subdivision_rec->name();

=head1 DESCRIPTION

This class contains the subdivision-level data associated with an IP address. A
subdivision is a sub-country level administrative boundary, such as a province or
state.

This record is returned by all the end points except the Country end point.

=head1 METHODS

This class provides the following methods:

=head2 $subdivision_rec->confidence()

This returns a value from 0-100 indicating MaxMind's confidence that the
subdivision is correct.

This attribute is only available from the Omni end point.

=head2 $subdivision_rec->geoname_id()

This returns a C<geoname_id> for the subdivision.

This attribute is returned by all end points except the Country end point.

=head2 $subdivision_rec->iso_code()

This returns a string up to three characters long contain the subdivision portion
of the ISO 3166-2 code (http://en.wikipedia.org/wiki/ISO_3166-2).

This attribute is returned by all end points except the Country end point.

=head2 $subdivision_rec->name()

This returns a name for the subdivision. The language chosen depends on the
C<languages> argument that was passed to the record's constructor. This will
be passed through from the L<GeoIP2::WebService::Client> object you used to
fetch the data that populated this record.

If the record does not have a name in any of languages you asked for, this
method returns C<undef>.

This attribute is returned by all end points except the Country end point.

=head2 $subdivision_rec->names()

This returns a hash reference where the keys are language codes and the values
are names. See L<GeoIP2::WebService::Client> for a list of the possible
language codes.

This attribute is returned by all end points except the Country end point.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
