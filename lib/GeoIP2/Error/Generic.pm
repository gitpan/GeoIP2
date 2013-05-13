package GeoIP2::Error::Generic;
{
  $GeoIP2::Error::Generic::VERSION = '0.0100';
}

use strict;
use warnings;

use GeoIP2::Types qw( Str );

use Moo;

extends 'Throwable::Error';

1;

# ABSTRACT: A generic exception

__END__

=pod

=head1 NAME

GeoIP2::Error::Generic - A generic exception

=head1 VERSION

version 0.0100

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::Webservice::Client;
  use Scalar::Util qw( blessed );

  my $client = GeoIP2::Webservice::Client->new(
      user_id     => 42,
      license_key => 'abcdef123456',
  );

  try {
      $client->omni( ip => '24.24.24.24' );
  }
  catch {
      die $_ unless blessed $_;
      die $_ if $_->isa('GeoIP2::Error::Generic');

      # handle other exceptions
  };

=head1 DESCRIPTION

This class represents a generic error. It extends L<Throwable::Error> and does
not add any additional attributes.

=head1 METHODS

This class has two methods, C<< $error->message() >>, and C<<
$error->stack_trace() >>. Both methods are inherited from L<Throwable::Error>.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
