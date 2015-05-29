#!/usr/bin/env perl6

use lib 'lib';

use CSSGrammar;
use CSSMin;

my $cssmin = CSSMin.new();
my $parsed = CSSGrammar.parsefile(@*ARGS[0], :actions($cssmin));

say $parsed.made;
