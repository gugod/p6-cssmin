class CSSMin {
    my sub __concat_chunks($matched) {
        my $s = "";
        for $matched.chunks -> $c {
            next if $c.key eq '~';
            if defined( $c.value.made ) {
                $s ~= $c.value.made;
            } else {
                warn "(no val for { $c.key })";
            }
        }
        return $s;
    }

    method TOP($/) {
        my $s = "";
        for $/[0].list -> $x {
            $s ~= __concat_chunks($x);
        }
        $/.make: $s;
    }

    method cssimport($/) {
        $/.make: '@import ' ~ $/<where> ~ ';'
    }

    method cssrule($/) {
        $/.make: [
            $/<selector_list>.made,
            '{',
            ($/<property_kv>.values.map: { $_.made }).join(';'),
            '}'
        ].join("");
    }

    method selector_list($/) {
        $/.make: __concat_chunks($/); 
    }

    method selector($/) {
        my @o;
        my $sep = 0;
        for $/.chunks -> $c {
            given $c.key {
                when "simple_selector" {
                    if $sep != 0 {
                        @o.push: " ";
                    } else {
                        $sep--;
                    }
                    @o.push: $c.value.made;
                }
                when "combinator" {
                    $sep++;
                    @o.push: $c.value.made;
                }
            }
        }
        my $s = @o.join("");
        $/.make($s);
    }

    method simple_selector($/) {
        $/.make: __concat_chunks($/); 
    }

    method property_kv($/) {
        $/.make: $/<property_name>.made ~ ":" ~ $/<property_value>.made;
    }

    method comment($/) { $/.make: "" }
    method property_name($/) { $/.make: "$/".trim; }
    method property_value($/) { $/.make: "$/".trim; }
    method universal_selector($/) { $/.make: "*"; }
    method tag_selector($/) { $/.make: "$/".trim; }
    method id_selector($/) { $/.make: "$/".trim; }
    method class_selector($/) { $/.make: "$/".trim; }
    method combinator($/) { $/.make: "$/".trim; }
}
