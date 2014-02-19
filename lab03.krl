ruleset b505214x2 {
    meta {
        name "lab03"
        author "jason rasmusse"
        logging off
    }
    dispatch {
        // domain "exampley.com"
    }
    
    rule reset_rule {
        select when pageview ".*" setting ()
        pre {
            findClear = function(x) {
                parts = x.split(re/&/);
                names = parts.filter(function(y){
                    y.match(re/^clear=1/)
                });
                result = (names.length() == 0) => false | true;
                result
            };
            query = page:url("query");
            c = findClear(query);
        }
        
        if c then {
            noop();
        } fired {
            set ent:visits 0;
        }
    }
 
    rule show_form {
        select when pageview ".*" setting ()
        pre {
            form_html = << 
            <div>
                <form id="my_form" onsubmit="return false">
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input value="Submit" type="submit">
                </form> 
            </div>
            >>;
        }
        if(not ent:username) then {
            append("main", form_html);
            watch("#my_form", "submit");
        }
        fired {
            last;
        }
    }
    
    rule submit_rule {
        select when web submit "#my_form"
        pre {
            username = event:attr("firstname") + " " + event:attr("lastname");
        }
        replace_inner("#main", "Hello #{username}");
        fired {
            set ent:username username;
        }
    }
}

