package GeoIP2::Record::MaxMind;
$GeoIP2::Record::MaxMind::VERSION = '0.040003';
use strict;
use warnings;

use GeoIP2::Types qw( NonNegativeInt );

use Moo;

has queries_remaining => (
    is  => 'ro',
    isa => NonNegativeInt,
);

1;

# ABSTRACT: Contains data for the maxmind record returned from a web service query

__END__

=pod

=head1 NAME

GeoIP2::Record::MaxMind - Contains data for the maxmind record returned from a web service query

=head1 VERSION

version 0.040003

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  my $omni = $client->omni( ip => '24.24.24.24' );

  my $maxmind_rec = $omni->maxmind();
  say $maxmind_rec->queries_remaining();

=head1 DESCRIPTION

This class contains the maxmind record data returned from a web service query.

Unlike other record classes, the data in this record is associated with your
MaxMind account, not with an IP address.

This record is returned by all the end points.

=head1 METHODS

This class provides the following methods:

=head2 $maxmind_rec->queries_remaining()

The number of queries remaining for the end point you just queried. Note that
this is an approximation as query counts are only periodically synced across
all of MaxMind's servers.

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

This software is copyright (c) 2014 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
