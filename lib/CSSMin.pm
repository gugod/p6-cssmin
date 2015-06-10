class CSSMin {
    method TOP($/) {
        make( ($/<cssrule>.values.map: { $_.made }).join("") );
    }

    method cssrule($/) {
        my $s = [
            $/<selector_list>.values,
            '{',
            ($/<property_kv>.values.map: { $_.made }).join(';'),
            '}'
        ].join("");
        make( $s );
    }

    method selector_list($/) {
        make $/<selector>.values.join(",");
    }

    method selector($/) {
        my $s = ($/<simple_selector>.list.map: { $_.made }).join('-');
        make "$s";
    }

    method property_kv($/) {
        my $s = $/<property_name> ~ ":" ~ $/<property_value>;
        make($s);
    }

    method combinator($/) { make "$/" }
    method simple_selector($/) { make "$/" }
    method property_name($/) { make "$/" }
    method property_value($/) { make "$/" }
    method tag_selector($/) { make "$/" }
}
