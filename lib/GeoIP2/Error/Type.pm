package GeoIP2::Error::Type;
{
  $GeoIP2::Error::Type::VERSION = '0.040001';
}
BEGIN {
  $GeoIP2::Error::Type::AUTHORITY = 'cpan:TJMATHER';
}

use strict;
use warnings;

use Moo;

extends 'Throwable::Error';

# We can't load GeoIP2::Types to get types here because we'd have a circular
# use in that case.
has type => (
    is       => 'ro',
    required => 1,
);

has value => (
    is       => 'ro',
    required => 1,
);

1;

# ABSTRACT: A type validation error.

__END__

=pod

=head1 NAME

GeoIP2::Error::Type - A type validation error.

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
      if ( $_->isa('GeoIP2::Error::Type') ) {
          log_validation_error(
              type   => $_->name(),
              value  => $_->value(),
          );
      }

      # handle other exceptions
  };

=head1 DESCRIPTION

This class represents a Moo type validation error. It extends
L<Throwable::Error> and adds attributes of its own.

=head1 METHODS

The C<< $error->message() >>, and C<< $error->stack_trace() >> methods are
inherited from L<Throwable::Error>. It also provide two methods of its own:

=head2 $error->name()

Returns the name of the type which failed validation.

=head2 $error->value()

Returns the value which triggered the validation failure.

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
