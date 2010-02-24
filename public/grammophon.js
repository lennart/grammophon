var swfVersionStr = "10.0.0";
var xiSwfUrlStr = "";
var flashvars = {};
var params = {};
params.quality = "high";
params.bgcolor = "#ffffff";
params.allowscriptaccess = "sameDomain";
params.allowfullscreen = "true";
var attributes = {};
attributes.id = "Grammophon";  attributes.name = "Grammophon";
attributes.align = "middle";
swfobject.embedSWF(  
  "public/jukebox/Grammophon.swf", "flashContent",
  "100%", "100%",
  swfVersionStr, xiSwfUrlStr,
  flashvars, params, attributes);
/* First, set the client up with some callbacks. */
Playdar.setupClient({

    // Called when the browser is authorised to query Playdar.
    onAuth: function () {
      // At this point, we can query the Playdar API for a track and start polling for matches.
      alert("Connected");
    }


});

/* The client is now ready to check in with Playdar. */
Playdar.client.go();
