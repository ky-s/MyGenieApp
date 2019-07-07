require("../css/application.css");
require("../css/vendor.scss");


const WEBSOCKETS_SERVER = false;

if ( WEBSOCKETS_SERVER ) {
  require("./channels.js");
  WebChannels.load_channels();

  WebChannels.messageHandlers.push(function(event){
    console.log(event.data);
  });
}

import "bootstrap";
