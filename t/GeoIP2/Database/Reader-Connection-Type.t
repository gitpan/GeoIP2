use strict;
use warnings;

use Test::More;
use Test::Fatal;

use GeoIP2::Database::Reader;
use Path::Class qw( file );

{
    my $reader
        = GeoIP2::Database::Reader->new( file =>
            file(qw( maxmind-db test-data GeoIP2-Connection-Type-Test.mmdb ))
        );

    my $ip_address = '1.0.1.0';
    my $record = $reader->connection_type( ip => $ip_address );
    is(
        $record->connection_type, 'Cable/DSL',
        'correct connection type in Connection-Type database'
    );
    is(
        $record->ip_address, $ip_address,
        'correct IP in Connection-Type database'
    );
}

done_testing();
