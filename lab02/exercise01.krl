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
            notify("Hello " + name, "That was your name") with sticky = true;
        }
    }
    
    rule couting_rule {
        select when pageview ".*" setting ()
        pre {
            visits = ent:visits || 1; 
        } 
        if visits <= 5 then {
            notify("Visits", "You have visited " + visits + " times") with sticky = true;
        } 
        always {
            ent:visits += 1 from 1;
        }
    }
    
    rule reset_rule {
        select when pageview ".*" setting ()
        pre {
            findClear = function(x) {
                parts = x.split(re/&/);
                names = parts.filter(function(y){
                    y.match(re/clear=/)
                });
                result = (names.length() == 0) => false | true;
                result
            };
            query = page:url("query");
            c = findClear(query);
        }
        
        every {
            notify("Cleared!", "cleared! " + c + " <--") with sticky = true;
        } 
    }
           
           
}


