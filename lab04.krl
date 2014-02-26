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
        my_name = "bob";
        datasource rotten_search <- "http://api.rottentomatoes.com/api/public/v1.0/movies.json?";
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            movie_data = datasource:rotten_search("apikey=jabrgs5qz6jmsbk53jj9xg6k&age_limit=5&page=1&q=star wars");
            
        }
        
        every {
          notify("Hello", "This should work");
          append("#main", movie_data);
        }
    }
}
  



