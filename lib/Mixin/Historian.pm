use strict;
use warnings;
package Mixin::Historian;
use Mixin::ExtraFields 0.008 ();
use base 'Mixin::ExtraFields';

use Sub::Exporter -setup => {
  groups => {
    history => \'gen_fields_group',
  },
};

sub default_moniker { 'history' }

sub driver_base_class { 'Mixin::Historian::Driver' }

sub methods { qw(add) }

sub driver_method_name {
  my ($self, $method) = @_;
  $self->method_name($method, 'history');
}

sub build_method {
  my ($self, $method_name, $arg) = @_;

  # Remember that these are all passed in as references, to avoid unneeded
  # copying. -- rjbs, 2006-12-07
  my $id_method = $arg->{id_method};
  my $driver    = $arg->{driver};

  my $driver_method  = $self->driver_method_name($method_name);

  return sub {
    my $object = shift;
    my $id     = $object->$$id_method;
    Carp::confess "couldn't determine id for object" unless defined $id;
    $$driver->$driver_method({
      object => $object,
      mixin  => $self,
      id     => $id,
      args   => \@_,
    });
  };
}

1;
