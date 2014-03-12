ruleset b505214x5 {
  meta {
    name "Lab06Exercise"
    author "Jason Rasmussen"
    logging off
    //use module a169x701 alias CloudRain
    //use module a41x186  alias SquareTag
  }
  
  global {
    get_location_data = function(key) {
      map = ent:map;
      value = map{key};
      value
    }
  }
  
  rule add_location_item {
    select when pds new_location_data
    
    pre {
    
      key = event:attr("key");
      value = event:attr("value");
      
    }
  }
  
  rule test_location_item {
    select when web pageview
    
    pre {
      new_map = ent:map
      new_entry = {"hello": "world"}
      //new_map.put(new_entry)
      output = new_map{"hello"}
      
    }
    
    always {
      set ent:map new_map;
      notify("Done", output);
    }
  
  rule hello_world {
    select when web pageview
    notify("Hello", "Jason");
  }

}
