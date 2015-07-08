grammar CSSGrammar {
    rule TOP {
        (<comment> | <cssimport> | <cssrule>)*
    }

    token comment { '/*' .*? '*/'  }

    token cssimport {
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

    token property_kv {
        <property_name> ':' <property_value>
    }

    token property_name {
        '-'?(<alpha> | <.ident> | '-' | '*')*
    }

    rule selector {
        <simple_selector> +%% <combinator>?
    }

    rule simple_selector {
        [ <universal_selector> | <tag_selector> ] <id_selector>? <class_selector>* <pseudo_selector>*
        | <id_selector> <class_selector>*  <pseudo_selector>*	
        | <class_selector>+  <pseudo_selector>*
    }

    token pseudo_selector { ':' <.ident> }

    token property_value { <-[;]>+ }

    token universal_selector { '*' }

    token tag_selector { <.ident> }
    
    token id_selector { '#' <.ident> }

    token class_selector { '.' [ <.ident> | '-' ]+ }

    token combinator { [ '+' | '>' ] }

    method panic($e)  {die $e;}
}
