package GeoIP2::Role::Model::Flat;
$GeoIP2::Role::Model::Flat::VERSION = '2.001001';
use strict;
use warnings;

use Moo::Role;

with 'GeoIP2::Role::Model::Flat';

around BUILDARGS => sub {
    my $orig = shift;
    my $self = shift;

    my %p = @_;

    return $self->$orig( %{ $p{raw} }, %p );
};

1;
