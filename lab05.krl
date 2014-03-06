ruleset b505214x4 {
  meta {
    name "Lab05Exercise"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }

  rule process_checking {
    select when foursquare checkin
    
    pre {
      content = event:attr("checkin").decode();
      time = content.pick("$..createdAt");
      shout = content.pick("$..shout");
      name = content.pick("$..venue.name");
      city = content.pick("$..venue.location.city");
    }
    
    always {
      set ent:time time;
      set ent:shout shout;
      set ent:name name;
    }
  }
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      my_html = <<
      <div>
        <h1> Checkin Information </h1>
        <h2> Venue: #{ent:name} </h2><br>
        <h2> Shout: #{ent:shout} </h2><br>
        <h2> Time: #{ent:time} </h2><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab05", {}, my_html);
    }
  }
}
