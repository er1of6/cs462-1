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
      
        total = json_data.pick("$.total");
        movie = json_data.pick("$.movies[0]");
        
        image = movie.pick("$..thumbnail");
        title = movie.pick("$.title");
        year = movie.pick("$.year");
        synopsis = movie.pick("$.synopsis");
        critics_score = movie.pick("$..critics_score");
        audience_score = movie.pick("$..audience_score");
        critics_consensus = movie.pick("$..critics_consensus");
        
        html = <<
            <div style="width: 600px;">
              <h2>Results for: #{term}</h2>
              <h3><strong>Title: </strong> #{title}</h3><br>
              <img src="#{image}"/><br>
              <p1><strong>Year: </strong>#{year}</p1><br>
              <p1><strong>Synopsis: </strong>#{synopsis}</p1><br>
              <p1><strong>Critics Score: </strong>#{critics_score}</p1><br>
              <p1><strong>Audience Score: </strong>#{audience_score}</p1><br>
              <p1><strong>Critics Consensus: </strong>#{critics_consensus}</p1><br>
            </div>
        >>;
        
        error = <<
          <div>
            <h2>No Results Found!</h2>
            <h3><strong>Search Title: </strong> #{term}</h3><br>
          </div>
        >>;
        
        result = total > 0 => html | error;
        result
    }
  }
  
  rule send_form {
     select when web pageview
        pre {
            form_html = 
            <<
                <form id="my_form" onsubmit="return false">
                    <input type="text" name="movie"/>
                    <input type="submit" value="Submit" />
                </form> 
                <div id="results"></div>
            >>;
        }
        
        every {
            notify("Alert", "Jason");
            replace_inner("#main", form_html);
            watch("#my_form", "submit");
        }
    }

    rule respond_submit {
        select when web submit "#my_form"
        pre {
            term = event:attr("movie");
            movie_html = get_movie_info(term);
        }
        replace_inner("#results", movie_html);
    }
}
    
    
