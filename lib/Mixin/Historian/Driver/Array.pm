use strict;
use warnings;
package Mixin::Historian::Driver::Array;
use base 'Mixin::Historian::Driver';

sub new {
  my ($class, $arg) = @_;

  return bless {
    array => [],
  } => $class;
}

sub _array {
  $_[0]{array};
}

sub entries {
  my ($self) = @_;
  return @{ $self->_array };
}

sub add_history {
  my ($self, $object, $id, $record) = @_;

  push @{ $self->_array }, $record;
}

1;
