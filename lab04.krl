ruleset b505214x3 {
  meta {
    name "Rotten Tomatoes Exercise"
    description "Using the Rotten Tomatoes API"
    author "Jason Rasmussen"
    logging off
  }
  dispatch {
  }
  
  global {
    get_movie_info = function(term) {
      r = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json", {"apikey" : "jabrgs5qz6jmsbk53jj9xg6k", "q" : term});
      json_data = r.pick("$.content").decode();
      ret = "Movies: " + json_data.filter(function(k,v){k eq "movies"});
      ret
    }
  }
  

  rule send_form {
     select when web pageview
        pre {
            a_form = 
            <<
                <form id="my_form" onsubmit="return false">
                    <input type="text" name="movie"/>
                    <input type="submit" value="Submit" />
                </form> 
            >>;
        }
        
        every {
            notify("Alert", "Jason");
            replace_inner("#main", get_movie_info("star wars"));
            //watch("#my_form", "submit");
        }
    }

    rule respond_submit {
        select when web submit "#my_form"
        pre {
            moviename = event:attr("movie");
            data = get_movie_info(moviename);
        }
        replace_inner("#info", data);
    }
}
