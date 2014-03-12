ruleset b505214x5 {
  meta {
    name "Lab06Exercise"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  
  global {

  }
  
  rule add_location_item {
    select when pds new_location_data
    pre {
      key = event:attr("key");
      value = event:attr("value");
      dict = ent:dict || {};
      dict = dict.put([key], value);
    }
    
    always {
      set ent:dict dict;
    }
  }
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      //dict = ent:dict || {};
      value = dict{"fs_checkin"};
      my_html = <<
      <div>
          <h1> Lab06 Information </h1>
          <h2> Here </h2><br>
          <h2> FS_CHECKIN: #{value} </h2><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab06", {}, my_html);
      //notify("MAP", dict.as("str"));
    }
  }
}
