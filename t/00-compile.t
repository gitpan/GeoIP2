use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.051

use Test::More;

plan tests => 35 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'GeoIP2.pm',
    'GeoIP2/Database/Reader.pm',
    'GeoIP2/Error/Generic.pm',
    'GeoIP2/Error/HTTP.pm',
    'GeoIP2/Error/IPAddressNotFound.pm',
    'GeoIP2/Error/Type.pm',
    'GeoIP2/Error/WebService.pm',
    'GeoIP2/Model/AnonymousIP.pm',
    'GeoIP2/Model/City.pm',
    'GeoIP2/Model/ConnectionType.pm',
    'GeoIP2/Model/Country.pm',
    'GeoIP2/Model/Domain.pm',
    'GeoIP2/Model/ISP.pm',
    'GeoIP2/Model/Insights.pm',
    'GeoIP2/Record/City.pm',
    'GeoIP2/Record/Continent.pm',
    'GeoIP2/Record/Country.pm',
    'GeoIP2/Record/Location.pm',
    'GeoIP2/Record/MaxMind.pm',
    'GeoIP2/Record/Postal.pm',
    'GeoIP2/Record/RepresentedCountry.pm',
    'GeoIP2/Record/Subdivision.pm',
    'GeoIP2/Record/Traits.pm',
    'GeoIP2/Role/Error/HTTP.pm',
    'GeoIP2/Role/HasIPAddress.pm',
    'GeoIP2/Role/HasLocales.pm',
    'GeoIP2/Role/Model.pm',
    'GeoIP2/Role/Model/Flat.pm',
    'GeoIP2/Role/Model/HasSubdivisions.pm',
    'GeoIP2/Role/Model/Location.pm',
    'GeoIP2/Role/Record/Country.pm',
    'GeoIP2/Role/Record/HasNames.pm',
    'GeoIP2/Types.pm',
    'GeoIP2/WebService/Client.pm'
);

my @scripts = (
    'bin/web-service-request'
);

# no fake home requested

my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}

foreach my $file (@scripts)
{ SKIP: {
    open my $fh, '<', $file or warn("Unable to open $file: $!"), next;
    my $line = <$fh>;

    close $fh and skip("$file isn't perl", 1) unless $line =~ /^#!\s*(?:\S*perl\S*)((?:\s+-\w*)*)(?:\s*#.*)?$/;
    my @flags = $1 ? split(' ', $1) : ();

    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, @flags, '-c', $file);
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$file compiled ok");

   # in older perls, -c output is simply the file portion of the path being tested
    if (@_warnings = grep { !/\bsyntax OK$/ }
        grep { chomp; $_ ne (File::Spec->splitpath($file))[2] } @_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
} }



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', ( Test::More->can('explain') ? Test::More::explain(\@warnings) : join("\n", '', @warnings) ) if $ENV{AUTHOR_TESTING};


