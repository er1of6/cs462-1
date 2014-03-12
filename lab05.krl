ruleset b505214x4 {
  meta {
    name "Lab05Exercise"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  
  rule abcdef {
    select when web pageview
    
    always {
      raise pds event 'new_location_data' for 'b505214x5' with key="fs_checkin" and value="foo";
    }
    
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
      set ent:city city;
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
        <h2> City: #{ent:city} </h2><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab05", {}, my_html);
    }
  }
}
