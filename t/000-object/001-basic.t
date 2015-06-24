#!perl

use strict;
use warnings;

use Test::More;

use Scalar::Util qw[ reftype blessed ];

BEGIN {
    use_ok('mop::object');
}

{
    package Foo;
    use strict;
    use warnings;
    our @ISA = ('mop::object');
}

subtest '... simple mop::object test' => sub {
    my $o = mop::object->new( foo => 'BAR' );
    isa_ok($o, 'mop::object');

    is(blessed $o, 'mop::object', '... got the expected class name');
    is(reftype $o, 'HASH', '... got the expected default repr type');
    
    ok(exists $o->{foo}, '... got the expected slot');
    is($o->{foo}, 'BAR', '... the expected slot has the expected value');
};

subtest '... simple mop::object subclass test' => sub {
    my $o = Foo->new( foo => 'BAR' );
    isa_ok($o, 'Foo');
    isa_ok($o, 'mop::object');

    is(blessed $o, 'Foo', '... got the expected class name');
    is(reftype $o, 'HASH', '... got the expected default repr type');
    
    ok(exists $o->{foo}, '... got the expected slot');
    is($o->{foo}, 'BAR', '... the expected slot has the expected value');
};

done_testing;
