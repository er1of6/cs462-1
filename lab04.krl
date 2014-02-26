ruleset b505214x3 {
    meta {
        name "lab04"
        author "jason rasmussen"
        logging off
    }
    
    dispatch {
        // domain "exampley.com"
    }
    
    global {
        dataset example <- "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=jabrgs5qz6jmsbk53jj9xg6k";
        my_name = "bob"
    
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            
            
        }
        
        every {
          notify("Hello", my_name);
          append("#main", example);
        }
    }
}
  
