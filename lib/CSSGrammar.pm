grammar CSSGrammar {
    rule TOP {
        <cssrule>*
    }

    rule cssrule {
        <selector_list> '{' <property_kv> * %% ';'  '}'
    }

    rule selector_list {
        <selector>+ %% ','
    }

    rule property_kv {
        <property_name> ':' <property_value>
    }

    token property_name {
        '-'?<alpha>(<.ident> | '-')*
    }

    token selector {
        <simple_selector>+ %% <.ws>
    }

    token simple_selector {
        ( <universal_selector> | <tag_selector> ) <id_selector>? <class_selector>*
        | <id_selector> <class_selector>*
        | <class_selector>+
    }

    token property_value { <-[;]>+ }

    token universal_selector { "*" }

    token tag_selector { <.ident> }
    
    token id_selector { "#" <.ident> }

    token class_selector { "." (<.ident> | '-' )+ }
}
