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
                <form>
                    First name: <input type="text" name="firstname"><br>
                    Last name: <input type="text" name="lastname">
                    <input type="submit" value="Submit">
                </form>  
            >>
        }
        {
            replace_inner('#main', form_html);
        }
    }
}
