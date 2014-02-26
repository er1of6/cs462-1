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
        
        //?q={search-term}&page_limit={results-per-page}&page={page-number}"
        
        base_url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json"
        
        findMovie = function(search_term){
            data = http:get(base_url + "?apikey=jabrgs5qz6jmsbk53jj9xg6k&q=" + search_term + "&page_limit=5&page=1")
            data
        }
    
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            
            
        }
        
        every {
          notify("Hello", findMove("Star Wars);
          append("#main", example);
        }
    }
}
  
