
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/web-service-request',
    'lib/GeoIP2.pm',
    'lib/GeoIP2/Database/Reader.pm',
    'lib/GeoIP2/Error/Generic.pm',
    'lib/GeoIP2/Error/HTTP.pm',
    'lib/GeoIP2/Error/IPAddressNotFound.pm',
    'lib/GeoIP2/Error/Type.pm',
    'lib/GeoIP2/Error/WebService.pm',
    'lib/GeoIP2/Model/City.pm',
    'lib/GeoIP2/Model/ConnectionType.pm',
    'lib/GeoIP2/Model/Country.pm',
    'lib/GeoIP2/Model/Domain.pm',
    'lib/GeoIP2/Model/ISP.pm',
    'lib/GeoIP2/Model/Insights.pm',
    'lib/GeoIP2/Record/City.pm',
    'lib/GeoIP2/Record/Continent.pm',
    'lib/GeoIP2/Record/Country.pm',
    'lib/GeoIP2/Record/Location.pm',
    'lib/GeoIP2/Record/MaxMind.pm',
    'lib/GeoIP2/Record/Postal.pm',
    'lib/GeoIP2/Record/RepresentedCountry.pm',
    'lib/GeoIP2/Record/Subdivision.pm',
    'lib/GeoIP2/Record/Traits.pm',
    'lib/GeoIP2/Role/Error/HTTP.pm',
    'lib/GeoIP2/Role/HasIPAddress.pm',
    'lib/GeoIP2/Role/HasLocales.pm',
    'lib/GeoIP2/Role/Model.pm',
    'lib/GeoIP2/Role/Model/Flat.pm',
    'lib/GeoIP2/Role/Model/HasSubdivisions.pm',
    'lib/GeoIP2/Role/Model/Location.pm',
    'lib/GeoIP2/Role/Record/Country.pm',
    'lib/GeoIP2/Role/Record/HasNames.pm',
    'lib/GeoIP2/Types.pm',
    'lib/GeoIP2/WebService/Client.pm',
    't/GeoIP2/Database/Reader.t',
    't/GeoIP2/Error/Type.t',
    't/GeoIP2/Model/City.t',
    't/GeoIP2/Model/Country.t',
    't/GeoIP2/Model/Insights.t',
    't/GeoIP2/Model/names.t',
    't/GeoIP2/Types.t',
    't/GeoIP2/WebService/Client.t',
    't/author-no-tabs.t',
    't/lib/Test/GeoIP2.pm',
    't/release-cpan-changes.t',
    't/release-eol.t',
    't/release-pod-coverage.t',
    't/release-pod-spell.t',
    't/release-pod-syntax.t',
    't/release-synopsis.t'
);

notabs_ok($_) foreach @files;
done_testing;
