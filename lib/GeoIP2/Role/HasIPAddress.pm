package GeoIP2::Role::HasIPAddress;
$GeoIP2::Role::HasIPAddress::VERSION = '0.040005';
use strict;
use warnings;

use GeoIP2::Types qw( IPAddress );

use Moo::Role;

has ip_address => (
    is       => 'ro',
    isa      => IPAddress,
    required => 1,
);

1;
