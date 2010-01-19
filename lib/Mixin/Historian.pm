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

1;
