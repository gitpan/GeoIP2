package GeoIP2::Record::RepresentedCountry;
$GeoIP2::Record::RepresentedCountry::VERSION = '2.001002';
use strict;
use warnings;

use GeoIP2::Types qw( Str );

use Moo;

with 'GeoIP2::Role::Record::Country';

has type => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_type',
);

1;

# ABSTRACT: Contains data for the represented country record associated with an IP address

__END__

=pod

=head1 NAME

GeoIP2::Record::RepresentedCountry - Contains data for the represented country record associated with an IP address

=head1 VERSION

version 2.001002

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  my $insights = $client->insights( ip => '24.24.24.24' );

  my $country_rec = $insights->reprented_country();
  say $country_rec->name();
  say $country_rec->type();

=head1 DESCRIPTION

This class contains the country-level data associated with an IP address for
the IP's represented country. The represented country is the country
represented by something like a military base.

This record is returned by all the end points.

=head1 METHODS

This class provides the following methods:

=head2 $country_rec->confidence()

This returns a value from 0-100 indicating MaxMind's confidence that the
country is correct.

This attribute is only available from the Insights end point.

=head2 $country_rec->geoname_id()

This returns a C<geoname_id> for the country.

This attribute is returned by all end points.

=head2 $country_rec->iso_code()

This returns the two-character ISO 3166-1
(L<http://en.wikipedia.org/wiki/ISO_3166-1>) alpha code for the country.

This attribute is returned by all end points.

=head2 $country_rec->name()

This returns a name for the country. The locale chosen depends on the
C<locales> argument that was passed to the record's constructor. This will be
passed through from the L<GeoIP2::WebService::Client> object you used to fetch
the data that populated this record.

If the record does not have a name in any of the locales you asked for, this
method returns C<undef>.

This attribute is returned by all end points.

=head2 $country_rec->names()

This returns a hash reference where the keys are locale codes and the values
are names. See L<GeoIP2::WebService::Client> for a list of the possible
locale codes.

This attribute is returned by all end points.

=head2 $country_rec->type()

This returns a string indicating the type of entity that is representing the
country. Currently we only return C<military> but this could expand to include
other types in the future.

This attribute is returned by all end points.

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

This software is copyright (c) 2013 - 2014 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
