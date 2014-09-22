package GeoIP2::Role::Model;
$GeoIP2::Role::Model::VERSION = '2.000001';
use strict;
use warnings;

use GeoIP2::Types qw( HashRef );

use Moo::Role;

has raw => (
    is       => 'ro',
    isa      => HashRef,
    init_arg => 'raw',
    required => 1,
);

1;
