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
        make $/.values.join("");
    }

    method property_kv($/) {
        my $s = $/<property_name> ~ ":" ~ $/<property_value>;
        make($s);
    }

    method property_name($/) {
        make "$/"
    }
    method property_value($/) {
        make "$/"
    }

    method tag_selector($/) {
        make "$/";
    }
}

