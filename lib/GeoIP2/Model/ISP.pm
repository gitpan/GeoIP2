package GeoIP2::Model::ISP;
$GeoIP2::Model::ISP::VERSION = '0.050001';
use strict;
use warnings;

use GeoIP2::Types qw( IPAddress NonNegativeInt Str );

use Moo;

with 'GeoIP2::Role::Model::Flat', 'GeoIP2::Role::HasIPAddress';

has autonomous_system_number => (
    is        => 'ro',
    isa       => NonNegativeInt,
    predicate => 'has_autonomous_system_number',
);

has autonomous_system_organization => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_autonomous_system_organization',
);

has isp => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_isp',
);

has organization => (
    is        => 'ro',
    isa       => Str,
    predicate => 'has_organization',
);

1;

# ABSTRACT: Model class for the GeoIP2 ISP database

__END__

=pod

=head1 NAME

GeoIP2::Model::ISP - Model class for the GeoIP2 ISP database

=head1 VERSION

version 0.050001

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::Model::ISP;

  my $record = GeoIP2::Model::ISP->new(
      raw => {
          autonomous_system_number => '217',
          autonomous_system_organization => 'University of Minnesota',
          isp => 'University of Minnesota',
          organization => 'University of Minnesota',
          ip_address => '128.101.101.101',
      }
  );

  say $record->autonomous_system_number();
  say $record->autonomous_system_organization();
  say $record->isp();
  say $record->organization();

=head1 DESCRIPTION

This class provides a model for GeoIP2 Connection-Type.

=head1 METHODS

This class provides the following methods:

=head2 $record->autonomous_system_number()

This returns the autonomous system number
(L<http://en.wikipedia.org/wiki/Autonomous_system_(Internet)>) associated with
the IP address.

=head2 $record->autonomous_system_organization()

This returns the organization associated with the registered autonomous system
number (L<http://en.wikipedia.org/wiki/Autonomous_system_(Internet)>) for the IP
address.

=head2 $record->ip_address()

Returns the IP address used in the lookup.

=head2 $record->isp()

This returns the name of the ISP associated with the IP address.

=head2 $record->organization()

This returns the name of the organization associated with the IP address.

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
