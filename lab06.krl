ruleset b505214x5 {
  meta {
    name "Lab06Exercise"
    author "Jason Rasmussen"
    logging off
    //use module a169x701 alias CloudRain
    //use module a41x186  alias SquareTag
  }
  
  rule add_location_item {
    select when pds new_location_data
    key = event:attr("key");
    value = event:attr("value");
  
  }
  
  rule hello_world {
    select when web pageview
    notify("Hello", "Jason");
  }

}
