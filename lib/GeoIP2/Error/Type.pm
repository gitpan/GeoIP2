package GeoIP2::Error::Type;
{
  $GeoIP2::Error::Type::VERSION = '0.0300';
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

version 0.0300

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

=head1 AUTHOR

Dave Rolsky <drolsky@maxmind.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
