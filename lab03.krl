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
        pre {
            form_html = << 
                <form id="my_form" onsubmit="return false">
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input id="watched" value="Submit" type="submit">
                </form>  
            >>
        }
        {
            replace_inner('#main', form_html);
            watch("#watched", "click");
            watch("#my_form", "submit");
        }
    }
    
    rule clicked_rule {
        select when web click "#watched"
        {
            notify("You clicked", "The submit button!");
        }
    }
    
    rule submit_rule {
        select when web submit "#my_form"
        {
            notify("Clicked Here", "");
        }
    
    }
}
