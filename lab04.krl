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
        base_url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?";
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            findMovie = function(search_term){
                movie_data = http:get("apikey=jabrgs5qz6jmsbk53jj9xg6k&page_limit=5&page=1&q=star wars");
                movie_data
            };
            
            
        }
        
        every {
          notify("Hello", movie_data);
          append("#main", movie_data);
        }
    }
}
  



