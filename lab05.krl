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
      time = content.pick("$.createdAt");
      shout = content.pick("$.shout");
      name = content.pick("$.venue.name");

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
      value = ent:checkin;
      content = ent:content;
      content = content.as("str");
      my_html = <<
      <div>
        <h1> Checkin Information: <h1?
        <h3> Venue: #{ent:name} </h3><br>
        <h3> Shout: #{ent:shout} </h3><br>
        <h3> Time: #{ent:time} </h3><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Hello World!", {}, my_html);
    }
  }
}
