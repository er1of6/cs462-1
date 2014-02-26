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
      movie = json_data.pick("$.movies[0]");
      
      image = movie.pick("$..thumbnail");
      title = movie.pick("$.title");
      year = movie.pick("$.year");
      synopsis = movie.pick("$.synopsis");
      critics_score = movie.pick("$..critics_score");
      audience_score = movie.pick("$..audience_score");
      critics_consensus = movie.pick("$..critics_consensus");
      
      html = <<
          <div style="width=300px; float: left; background-color: blue">
            <h3>Title: #{title}</h3><br>
            <img src="#{image}"/><br>
            <p1>Year: #{year}</p1><br>
            <p1>Synopsis: #{synopsis}</p1><br>
            <p1>Critics Score: #{critics_score}</p1><br>
            <p1>Audience Score: #{audience_score}</p1><br>
            <p1>Critics Consensus: #{critics_consensus}</p1><br>
          </div>
      >>;
      html
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
            movie_html = get_movie_info("star wars");
        }
        
        every {
            notify("Alert", "Jason");
            replace_inner("#main", movie_html);
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
