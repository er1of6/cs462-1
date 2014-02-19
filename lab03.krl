ruleset b505214x2 {
    meta {
        name "lab03"
        author "jason rasmusse"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
 
    rule show_form {
        select when pageview ".*" setting ()
        replace_inner("#main", "random text goes here...");
    }
}
