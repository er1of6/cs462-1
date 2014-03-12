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
      dict = ent:dict;
      value = dict{key};
      value
    }
    
    put_location_data = function(key, value){
      dict = ent:dict || {};
      dict = dict.put({key.as("str"):value.as("str")});
      dict
    }
  }
  
  rule add_location_item {
    select when explicit new_location_data
    pre {
      key = event:attr("key");
      value = event:attr("value");
    }
    
    every {
      notify("Results", key.as("str")) with sticky = true
    }
  }
  
  rule test_location_item {
    select when web pageview
    
    pre {
      new_dict = ent:dict || {};
      new_dict = new_dict.put({"test":"world2"});
      new_dict = new_dict.put({"hello":"world"});
      //output = new_dict{"hello"}
    }
    
    every {
          notify("Done", new_dict.as("str"));
    }
    
    always {
      set ent:dict new_dict;
    }
  }
  
  rule hello_world {
    select when web pageview
    notify("Hello", "Jason");
  }

}
