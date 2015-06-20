#!/usr/bin/env perl6

use lib 'lib';

use CSSGrammar;
use CSSMin;

my $cssmin = CSSMin.new();

my $thing = IO::Path.new(@*ARGS[0]).slurp;

my $parsed = CSSGrammar.subparse($thing, :actions($cssmin));

if ( $parsed.to < $thing.chars ) {
    say "{$parsed.to} ... {$thing.chars}";
    say $thing.substr(0,$parsed.to) ~ '⏏' ~ $thing.substr($parsed.to+1);
}
say $parsed.made;
# say $parsed.gist;
