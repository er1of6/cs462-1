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
        every {
            notify("Hello World1", "This is a sample rule.") with sticky = true;
            notify("Hello World2", "This is another sample rule.") with sticky = true;
        }
    }
    
    rule second_rule {
        select when pageview ".*" setting ()
        
        pre {
            name = findName(page:url("query"));
            if(name.length() == 0){
                name = "Monkey";
            findName = function(x) {
                x
            };
        }
        
        every {
            notify("Hello " + name, "This is another sample rule.") with sticky = true;
            notify(add5(7), "test") with sticky = true;
        }
    }
}
