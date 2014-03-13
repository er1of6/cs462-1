ruleset b505214x6 {
    meta {
        name "Lab06PartTwo"
        author "Jason Rasmussen
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
        use module b505214x5 alias location
    }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        
        pre {
          r = location:get_location_data('fs_checkin');
          name = r.pick("$..venue");
          city = r.pick("$..city");
          shout = r.pick("$..shout");
          time = r.pick("$..createdAt");
          
          my_html = <<
              <h5>Hello, world!</h5>
              Venue: #{name} </br>
              City: #{city} </br>
              shout: #{shout} </br>
              createdAt: #{time} </br>
              >>;
        }
        
        every {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Lab06a", {}, my_html);
        }
    }   
}
