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
        datasource rotten_search <- "http://api.rottentomatoes.com/api/public/v1.0/movies.json?";
        read = function(term){
            datasource:rotten_search({ "q": term, "apikey": "jabrgs5qz6jmsbk53jj9xg6k" }).pick("$..total");
        }
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            findMovie = function(search_term){
                movie_data = http:get(base_url, { "apikey": "jabrgs5qz6jmsbk53jj9xg6k", "q": "starwars" });
                movie_data
            };
            test = findMovie("bob").as("str");
            value = read("star wars");
            msg = <<
                <div>Hello!</div>
                <p>#{value}</p>
            >>;
        }
        
        every {
          notify("Hello", "Jason");
          replace_inner("#main", msg);
        }
    }
}
  



