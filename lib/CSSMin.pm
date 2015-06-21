class CSSMin {
    my sub __concat_chunks($matched) {
        my $s = "";
        for $matched.chunks -> $c {
            next if $c.key eq '~';
            $s ~= $c.value.made;
        }
        return $s;
    }

    method TOP($/) {
        $/.make( ($/<cssrule>.values.map: { $_.made }).join("") );
    }

    method cssrule($/) {
        my $s = [
            $/<selector_list>.made,
            '{',
            ($/<property_kv>.values.map: { $_.made }).join(';'),
            '}'
        ].join("");
        $/.make( $s );
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
        my $s = $/<property_name> ~ ":" ~ $/<property_value>;
        $/.make($s);
    }

    method tag_selector($/) { $/.make: "$/".trim; }
    method id_selector($/) { $/.make: "$/".trim; }
    method class_selector($/) { $/.make: "$/".trim; }
    method combinator($/) { $/.make: "$/".trim; }
}
