ruleset b505214x3 {
  meta {
    name "Rotten Tomatoes Exercise"
    description "
      Using the Rotten Tomatoes API
    >>
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186 alias SquareTag
  }
  dispatch {
  }
  
  global {
    get_movie_info = function(term) {
      r = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json", {"apikey" : "jabrgs5qz6jmsbk53jj9xg6k", "q" : term});
      ret = "movies: " + r.pick("$.content[1]").length();
      ret
    }
  }
  rule HelloWorld {
    select when web pageview
    pre {
      my_html = <<
        <div id = "info">
          Type in the movie that you're looking for
        </div>
        <div id="main">
          This code will all be replaced.
        </div> >>;
    }
    {
      //SquareTag:inject_styling();
      //CloudRain:createLoadPanel("Rotten Tomatoes movie deets right at your fingertips!", {}, my_html);
      append("body", my_html);
    }
  }
  

  rule send_form {
     select when web pageview
        // Display notification that will not fade.
        pre {
            a_form = <<
                <form id="my_form" onsubmit="return false">
                    <input type="text" name="movie"/>
                    <input type="submit" value="Submit" />
                </form> >>;
        }
        {
            replace_inner("#main", a_form);
            watch("#my_form", "submit");
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
