ruleset b505214x4 {
  meta {
    name "Rotten Tomatoes Exercise"
    description "Using the Rotten Tomatoes API"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }


  rule process_checking {
    select when foursquare checkin
    
    pre {
      
    
    }
    
    always {
      set ent:checkin true;
    }
  }
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      //value = ent:checkin
      my_html = <<
      <div>
        Hello!
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Hello World!", {}, my_html);
    }
  }
}
