#!perl
use strict;
use warnings;

use Test::More;

use Mixin::Historian;
use Mixin::Historian::Driver::Array;

my $driver;
BEGIN {
  $driver = Mixin::Historian::Driver::Array->new;
}

{
  package TestObject;
  use Mixin::Historian -history => {
    driver => $driver,
    type   => {
      chargen => [ qw(class alignment) ],
      levelup => { indexed => [ qw(enemy new_level) ] },
      death   => [ qw(killer implement) ],
    }
  };

  sub new {
    my ($class, $id) = @_;
    return bless { id => $id } => $class;
  }

  sub id { $_[0]{id} }
}

my $object = TestObject->new(10);
isa_ok($object, 'TestObject');

$object->add_history({
  type  => 'chargen',
  agent => 'mailto:rjbs@example.com',
  via   => 'ip://10.20.30.40',
  data  => {
    class     => 'paladin',
    alignment => 'Lawful Good',
    deity     => 'Cuthbert',
  },
});

is_deeply(
  [ $driver->entries ],
  [
    {
      type  => 'chargen',
      agent => 'mailto:rjbs@example.com',
      via   => 'ip://10.20.30.40',
      data  => {
        class     => 'paladin',
        alignment => 'Lawful Good',
        deity     => 'Cuthbert',
      },
    },
  ],
);

done_testing;
