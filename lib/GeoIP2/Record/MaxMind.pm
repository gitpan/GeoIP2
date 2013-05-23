package GeoIP2::Record::MaxMind;
{
  $GeoIP2::Record::MaxMind::VERSION = '0.0300';
}

use strict;
use warnings;

use GeoIP2::Types qw( NonNegativeInt );

use Moo;

has queries_remaining => (
    is       => 'ro',
    isa      => NonNegativeInt,
    required => 1,
);

1;

# ABSTRACT: Contains data for the maxmind record returned from a web service query

__END__

=pod

=head1 NAME

GeoIP2::Record::MaxMind - Contains data for the maxmind record returned from a web service query

=head1 VERSION

version 0.0300

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  my $city = $client->city_isp_org( ip => '24.24.24.24' );

  my $maxmind_rec = $city->maxmind();
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

=head1 AUTHOR

Dave Rolsky <drolsky@maxmind.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
