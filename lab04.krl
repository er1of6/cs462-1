ruleset b505214x3 {
    meta {
        name "lab04"
        author "jason rasmussen"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
    
    rule example_rule {
        select when web pageview
        pre {
            name = "jason";
        }
        
        every {
          notify("Hello", "Jason Rasmussen");
        }
    }
}
  
