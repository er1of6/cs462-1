ruleset b505214x5 {
  meta {
    name "Lab06Exercise"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
    
    provides get_location_data
  }
  
  global {
      get_location_data = function(key){
        theDict = ent:dict;
        value = theDict{key};
        value
      }
  }
  
  rule add_location_item {
    select when pds new_location_data
    
    pre {
      key = event:attr("key");
      value = event:attr("value");
      theDict = ent:dict;
      theOtherDict = theDict.put([key], value.encode());
    }
    
    send_directive(key) with key = "location" and value = value;
    
    always {
      set ent:dict theOtherDict;
    }
  }
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      key = "fs_checkin";
      value = get_location_data(key);
      
      my_html = <<
      <div>
          <h1> Lab06 Information </h1>
          <h2> Key: #{key} </h2><br>
          <h2> Value: #{value} </h2><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab06", {}, my_html);
    }
  }
}
