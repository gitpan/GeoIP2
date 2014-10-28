package GeoIP2::Role::Error::HTTP;
$GeoIP2::Role::Error::HTTP::VERSION = '2.001000';
use strict;
use warnings;

use GeoIP2::Types qw( HTTPStatus Str URIObject );

use Moo::Role;

has http_status => (
    is       => 'ro',
    isa      => HTTPStatus,
    required => 1,
);

has uri => (
    is       => 'ro',
    isa      => URIObject,
    required => 1,
);

1;
