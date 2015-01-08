package GeoIP2::Model::Country;
$GeoIP2::Model::Country::VERSION = '2.001002';
use strict;
use warnings;

use GeoIP2::Types qw( HashRef object_isa_type );
use Sub::Quote qw( quote_sub );

use Moo;

with 'GeoIP2::Role::Model::Location';

__PACKAGE__->_define_attributes_for_keys(
    qw( continent country maxmind registered_country traits ));

1;

# ABSTRACT: Model class for the GeoIP2 Precision: Country and GeoIP2 Country

__END__

=pod

=head1 NAME

GeoIP2::Model::Country - Model class for the GeoIP2 Precision: Country and GeoIP2 Country

=head1 VERSION

version 2.001002

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  my $country = $client->country( ip => '24.24.24.24' );

  my $country_rec = $country->country();
  say $country_rec->iso_code();

=head1 DESCRIPTION

This class provides a model for the data returned by the GeoIP2 Precision:
Country web service and the GeoIP2 Country database.

=head1 METHODS

This class provides the following methods, each of which returns a record
object.

=head2 $country->continent()

Returns a L<GeoIP2::Record::Continent> object representing continent data for
the requested IP address.

=head2 $country->country()

Returns a L<GeoIP2::Record::Country> object representing country data for the
requested IP address. This record represents the country where MaxMind
believes the IP is located.

=head2 $country->maxmind()

Returns a L<GeoIP2::Record::MaxMind> object representing data about your
MaxMind account.

=head2 $country->registered_country()

Returns a L<GeoIP2::Record::Country> object representing the registered
country data for the requested IP address. This record represents the country
where the ISP has registered a given IP block and may differ from the
user's country.

=head2 $country->represented_country()

Returns a L<GeoIP2::Record::RepresentedCountry> object for the country
represented by the requested IP address. The represented country may differ
from the C<country> for things like military bases.

=head2 $country->traits()

Returns a L<GeoIP2::Record::Traits> object representing the traits for the
requested IP address.

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
