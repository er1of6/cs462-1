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
      abc = "hello"
    }
    
    always {
      set ent:dict dict;
      set ent:abc abc;
    }
  }
  
  rule show_html {
    select when web cloudAppSelected
    
    pre {
      //dict = ent:dict || {};
      //value = dict{"fs_checkin"};
      abc = ent:abc;
      abc = abc.as("str");
      my_html = <<
      <div>
          <h1> Lab06 Information </h1>
          <h2> Here </h2><br>
          <h2> FS_CHECKIN: #{abc} </h2><br>
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
