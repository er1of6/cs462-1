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
            notify("Hello World1", "Notification #1") with sticky = true;
            notify("Hello World2", "Notification #2") with sticky = true;
        }
    }
    
    rule second_rule {
        select when pageview ".*" setting ()
        
        pre {
            findName = function(x) {
                parts = x.split(re/&/);
                names = parts.filter(function(y){
                    y.match(re/name=/)
                });
                result = (names.length() == 0) => "" | names[0].substr(5);
                result
            };
            query = page:url("query");
            name = findName(query);
            name = (name.length() > 0) => name | "Monkey";
        }
        
        every {
            notify("Hello " + name, "This is another sample rule.") with sticky = true;
        }
    }
    
    rule couting_rule {
        select when pageview ".*" setting ()
        pre { 
            hasClear = function(x) {
                parts = x.split(re/&/);
                clears = parts.filter(function(y){
                    y.match(re/clear=/)
                });
                result = (clears.length() == 0)
                result
            };
            query = page:url("query");
            clear = hasClear(query);
            visits = (ent:visits == null | clear) => 1 | ent:visits; 
        } 
        if visits <= 5 then
            notify("View Count", "You've visited " + visits + " times") with sticky = true;
        fired { 
            ent:visits += 1 from 2;
        }
    }
}


