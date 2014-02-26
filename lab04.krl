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
        base_url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json";
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            findMovie = function(search_term){
                raw_data = http:get(base_url, { "apikey": "jabrgs5qz6jmsbk53jj9xg6k", "q": "starwars" });
                movie_data = raw_data.pick("$.total");
                movie_data
            };
        }
        
        every {
          notify("Hello", "Jason");
          replace_inner("#main", "<div>" + findMovie("bob").as("str") + "</div>");
        }
    }
}
  



