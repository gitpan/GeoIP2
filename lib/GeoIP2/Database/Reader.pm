package GeoIP2::Database::Reader;
$GeoIP2::Database::Reader::VERSION = '2.001002';
use strict;
use warnings;

use Data::Validate::IP 0.24
    qw( is_ipv4 is_ipv6 is_private_ipv4 is_private_ipv6 );
use GeoIP2::Error::Generic;
use GeoIP2::Error::IPAddressNotFound;
use GeoIP2::Model::AnonymousIP;
use GeoIP2::Model::City;
use GeoIP2::Model::ConnectionType;
use GeoIP2::Model::Country;
use GeoIP2::Model::Domain;
use GeoIP2::Model::Insights;
use GeoIP2::Model::ISP;
use GeoIP2::Types qw( Str );
use MaxMind::DB::Reader 1.000000;

use Moo;

with 'GeoIP2::Role::HasLocales';

has file => (
    is       => 'ro',
    isa      => Str,
    required => 1,
    coerce   => sub { "$_[0]" },
);

has _reader => (
    is      => 'ro',
    does    => 'MaxMind::DB::Reader::Role::Reader',
    lazy    => 1,
    builder => '_build_reader',
    handles => ['metadata'],
);

sub _build_reader {
    my $self = shift;
    return MaxMind::DB::Reader->new( file => $self->file );
}

sub _model_for_address {
    my $self  = shift;
    my $class = shift;
    my %args  = @_;
    my $ip    = $args{ip};

    unless ( defined $ip ) {
        my ($method) = ( caller(1) )[3];
        GeoIP2::Error::Generic->throw( message =>
                "Required param (ip) was missing when calling $method on "
                . __PACKAGE__ );
    }

    unless ( $self->metadata->database_type =~ $args{type_check} ) {
        my ($method) = ( caller(1) )[3];
        GeoIP2::Error::Generic->throw( message => "The $method() on "
                . __PACKAGE__
                . ' cannot be used with the '
                . $self->metadata->database_type
                . ' database' );
    }

    if ( $ip eq 'me' ) {
        my ($method) = ( caller(1) )[3];
        GeoIP2::Error::Generic->throw(
                  message => "me is not a valid IP when calling $method on "
                . __PACKAGE__ );
    }

    if ( is_private_ipv4($ip) || is_private_ipv6($ip) ) {
        my ($method) = ( caller(1) )[3];
        GeoIP2::Error::Generic->throw(
                  message => "The IP address you provided ($ip) is not a "
                . "public IP address when calling $method on "
                . __PACKAGE__ );
    }

    my $record = $self->_reader->record_for_address($ip);
    unless ($record) {
        GeoIP2::Error::IPAddressNotFound->throw(
            message    => "No record found for IP address $ip",
            ip_address => $ip,
        );
    }

    my $model_class = 'GeoIP2::Model::' . $class;

    if ( $args{is_flat} ) {
        $record->{ip_address} = $ip;
    }
    else {
        $record->{traits} ||= {};
        $record->{traits}{ip_address} = $ip;
    }

    return $model_class->new( %{$record}, locales => $self->locales, );
}

sub city {
    my $self = shift;
    return $self->_model_for_address(
        'City',
        type_check => qr/City/,
        @_
    );
}

sub country {
    my $self = shift;
    return $self->_model_for_address(
        'Country',
        type_check => qr/^(?:GeoLite2|GeoIP2)-Country$/,
        @_
    );
}

sub connection_type {
    my $self = shift;
    return $self->_model_for_address(
        'ConnectionType',
        type_check => qr/^GeoIP2-Connection-Type$/,
        is_flat    => 1,
        @_
    );
}

sub domain {
    my $self = shift;
    return $self->_model_for_address(
        'Domain',
        type_check => qr/^GeoIP2-Domain$/,
        is_flat    => 1,
        @_
    );
}

sub isp {
    my $self = shift;
    return $self->_model_for_address(
        'ISP',
        type_check => qr/^GeoIP2-ISP$/,
        is_flat    => 1,
        @_
    );
}

sub anonymous_ip {
    my $self = shift;
    return $self->_model_for_address(
        'AnonymousIP',
        type_check => qr/^GeoIP2-Anonymous-IP$/,
        is_flat    => 1,
        @_,
    );
}

1;

# ABSTRACT: Perl API for GeoIP2 databases

__END__

=pod

=head1 NAME

GeoIP2::Database::Reader - Perl API for GeoIP2 databases

=head1 VERSION

version 2.001002

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::Database::Reader;

  my $reader = GeoIP2::Database::Reader->new(
      file    => '/path/to/database',
      locales => [ 'en', 'de', ]
  );

  my $city = $reader->city( ip => '24.24.24.24' );
  my $country = $city->country();
  say $country->iso_code();

=head1 DESCRIPTION

This class provides a reader API for all GeoIP2 databases. Each method returns
a different model class.

If the database does not return a particular piece of data for an IP address,
the associated attribute is not populated.

=head1 USAGE

The basic API for this class is the same for all database types.  First you
create a database reader object with your C<file> and C<locale> params.
Then you call the method corresponding to your database type, passing it the
IP address you want to look up.

If the request succeeds, the method call will return a model class for the
method point you called.

If the database cannot be read, the reader class throws an exception.

=head1 CONSTRUCTOR

This class has a single constructor method:

=head2 GeoIP2::Database::Reader->new()

This method creates a new object. It accepts the following arguments:

=over 4

=item * file

This is the path to the GeoIP2 database file which you'd like to query.

=item * locales

This is an array reference where each value is a string indicating a locale.
This argument will be passed on to record classes to use when their C<name()>
methods are called.

The order of the locales is significant. When a record class has multiple
names (country, city, etc.), its C<name()> method will look at each element of
this array ref and return the first locale for which it has a name.

Note that the only locale which is always present in the GeoIP2 data in "en".
If you do not include this locale, the C<name()> method may end up returning
C<undef> even when the record in question has an English name.

Currently, the valid list of locale codes is:

=over 8

=item * de - German

=item * en - English

English names may still include accented characters if that is the accepted
spelling in English. In other words, English does not mean ASCII.

=item * es - Spanish

=item * fr - French

=item * ja - Japanese

=item * pt-BR - Brazilian Portuguese

=item * ru - Russian

=item * zh-CN - simplified Chinese

=back

Passing any other locale code will result in an error.

The default value for this argument is C<['en']>.

=back

=head1 REQUEST METHODS

All of the request methods accept a single argument:

=over 4

=item * ip

This must be a valid IPv4 or IPv6 address. This is the address that you want to
look up using the GeoIP2 web service.

Unlike the web service client class, you cannot pass the string "me" as your ip
address.

=back

=head2 $reader->connection_type()

This method returns a L<GeoIP2::Model::ConnectionType> object.

=head2 $reader->country()

This method returns a L<GeoIP2::Model::Country> object.

=head2 $reader->city()

This method returns a L<GeoIP2::Model::City> object.

=head2 $reader->domain()

This method returns a L<GeoIP2::Model::Domain> object.

=head2 $reader->isp()

This method returns a L<GeoIP2::Model::ISP> object.

=head2 $reader->anonymous_ip()

This method returns a L<GeoIP2::Model::AnonymousIP> object.

=head1 OTHER METHODS

=head2 $reader->metadata()

This method returns a L<MaxMind::DB:Metadata> object containing information
about the database.

=head1 EXCEPTIONS

In the case of a fatal error, the reader will throw a L<GeoIP2::Error::Generic>
object.

This error class has an C<< $error->message() >> method and overload
stringification to show that message. This means that if you don't explicitly
catch errors they will ultimately be sent to C<STDERR> with some sort of
(hopefully) useful error message.

=head1 WHAT DATA IS RETURNED?

While many of the databases return the same basic records, the attributes which
can be populated vary between model classes. In addition, while a database may
offer a particular piece of data, MaxMind does not always have every piece of
data for any given IP address.

Because of these factors, it is possible for any model class to return a record
where some or all of the attributes are unpopulated.

See L<http://dev.maxmind.com/geoip/geoip2/web-services> for details on what
data each end point I<may> return.

Every record class attribute has a corresponding predicate method so you can
check to see if the attribute is set.

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <drolsky@maxmind.com>

=item *

Greg Oschwald <goschwald@maxmind.com>

=item *

Olaf Alders <oalders@maxmind.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 - 2014 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
