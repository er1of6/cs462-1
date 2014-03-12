ruleset b505214x5 {
  meta {
    name "Lab06Exercise"
    author "Jason Rasmussen"
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
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
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      my_html = <<
      <div>
          <h1> Lab06 Information </h1>
          <h2> Here </h2><br>
      </div>
      >>;
    }
    
    every {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Lab06", {}, my_html);
      notify("Here", "hello");
    }
  }
  
  rule test_location_item {
    select when web cloudAppSelected
    
    pre {
      new_dict = ent:dict || {};
      new_dict = new_dict.put({"test":"world2"});
      new_dict = new_dict.put({"hello":"world"});
      output = new_dict{"hello"}
    }
    
    every {
          notify("Output", output);
    }
    
    always {
      set ent:dict new_dict;
    }
  }
    
  rule add_location_item {
    select when pds new_location_data
    pre {
      key = event:attr("key");
      value = event:attr("value");
    }
    
    every {
      notify("Results", key.as("str"));
    }
  }

}
