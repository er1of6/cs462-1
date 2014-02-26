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
    }
    
    rule rotten_tomatoes {
        select when web pageview
        pre {
            name = "jason";
            findMovie = function(search_term){
                raw_data = http:get(base_url, { "apikey": "jabrgs5qz6jmsbk53jj9xg6k", "q": "starwars" });
                movie_data = raw_data.pick("$..movies[1]");
                //movie_data
                raw_data
            };
            test = findMovie("bob").as("str");
            test_data = datasource:rotten_search("q=starwars");
            output = test_data.pick("$..movies[0]");
            output1 = test_data.pick("$..movies");
            output2 = test_data.pick("$");
            msg = <<
                <div>Hello!</div>
                <p>#{output}</p>
                <p>#{output1}</p>
                <p>#{output2}</p>
            >>;
        }
        
        every {
          notify("Hello", "Jason");
          replace_inner("#main", msg);
        }
    }
}
  



