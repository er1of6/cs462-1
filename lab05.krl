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

    }
    
    always {
      set ent:checkin true;
      set ent:content content;
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
        update? #{value} <br>
        content #{content}
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Hello World!", {}, my_html);
    }
  }
}
