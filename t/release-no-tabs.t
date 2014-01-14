
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

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
    'lib/GeoIP2/Model/CityISPOrg.pm',
    'lib/GeoIP2/Model/Country.pm',
    'lib/GeoIP2/Model/Omni.pm',
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
    'lib/GeoIP2/Role/HasLocales.pm',
    'lib/GeoIP2/Role/Model.pm',
    'lib/GeoIP2/Role/Model/HasSubdivisions.pm',
    'lib/GeoIP2/Role/Record/Country.pm',
    'lib/GeoIP2/Role/Record/HasNames.pm',
    'lib/GeoIP2/Types.pm',
    'lib/GeoIP2/WebService/Client.pm'
);

notabs_ok($_) foreach @files;
done_testing;
