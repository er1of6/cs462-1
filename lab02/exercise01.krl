ruleset b505214x1 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        // Display notification that will not fade.
        notify("Hello World", "This is a sample rule.") with sticky = true;
    }
    
    rule second_rule {
        select when pageview ".*" setting ()
        // Display notification that will not fade.
        notify("Hello World Again", "This is a sample rule.") with sticky = true;
    }
}
