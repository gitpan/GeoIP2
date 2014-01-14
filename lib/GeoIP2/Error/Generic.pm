package GeoIP2::Error::Generic;
{
  $GeoIP2::Error::Generic::VERSION = '0.040001';
}
BEGIN {
  $GeoIP2::Error::Generic::AUTHORITY = 'cpan:TJMATHER';
}

use strict;
use warnings;

use Moo;

extends 'Throwable::Error';

1;

# ABSTRACT: A generic exception

__END__

=pod

=head1 NAME

GeoIP2::Error::Generic - A generic exception

=head1 VERSION

version 0.040001

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;
  use Scalar::Util qw( blessed );
  use Try::Tiny;

  my $client = GeoIP2::WebService::Client->new(
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

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <drolsky@maxmind.com>

=item *

Greg Oschwald <goschwald@maxmind.com>

=item *

Olaf Alders <oalders@maxmind.com>

=back

=head1 CONTRIBUTOR

Graham Knop <haarg@haarg.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
