package Mixin::Historian::Driver;
# ABSTRACT: base class for classes that act as Historian storage drivers

use strict;
use warnings;

=head1 METHODS

Classes extending Mixin::Historian::Driver are expected to provide the
following methods:

=head1 new

This method gets the driver configuration from the call to
L<Mixin::Historian>'s C<import> method and should return a new driver instance.

=head1 add_history

This method is passed an arrayref of the argument(s) to the generated and
installed C<add_history> method.  It is is expected to store the history entry.

=cut

1;
