grammar CSSGrammar {
    rule TOP {
        (<comment> | <cssimport> | <cssrule>)*
    }

    rule comment { '/*' .*? '*/'  }

    rule cssimport {
        '@import' $<where>=[.+?] ';'
    }

    rule cssrule {
        <selector_list> '{' <property_kv_list>* '}'
    }

    rule selector_list {
        <selector>+ %% ','
    }

    rule property_kv_list {
        <property_kv>+ %% ';'
    }

    rule property_kv {
        <property_name> ':' <property_value>
    }

    token property_name {
        '-'?<alpha>(<.ident> | '-')*
    }

    rule selector {
        <simple_selector> +%% <combinator>?
    }

    rule simple_selector {
        [ <universal_selector> | <tag_selector> ] <id_selector>? <class_selector>*
        | <id_selector> <class_selector>*
        | <class_selector>+
    }

    token property_value { <-[;]>+ }

    token universal_selector { '*' }

    token tag_selector { <.ident> }
    
    token id_selector { '#' <.ident> }

    token class_selector { '.' [ <.ident> | '-' ]+ }

    token combinator { [ '+' | '>' ] }

    method panic($e)  {die $e;}
}
