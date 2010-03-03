var GRAMMOPHON = {

  update_status: function(message) {
    document.getElementById("playdarStatus").innerHTML = message;
  },

  hide_status: function() {
    var status = document.getElementById("playdarStatus");
    status.parentNode.removeChild(status);
  },
  init: function() {

    /* First, set the client up with some callbacks. */
    Playdar.USE_STATUS_BAR = false;
    Playdar.auth_details.receiverurl = Playdar.Util.location_from_url("playdar_auth.html").href;
    Playdar.auth_details.type = "flash";
    Playdar.setupClient({
        onStat: function (detected) {
          if(detected) {
            GRAMMOPHON.update_status(Playdar.client.get_auth_link_html("Connect"));
          }
          else {
            GRAMMOPHON.update_status("No Playdar found");
          }
        },

        // Called when the browser is authorised to query Playdar.
        onAuth: function () {
          // var disconnect_link = Playdar.client.get_disconnect_link_html(
          //    STRINGS.disconnect_from_playdar_text
          //    );
          //GRAMMOPHON.update_status('<strong>'+Playdar.client.get_disconnect_link_html("Disconnect")+'</strong>');

          //      PLAYDAR.resolve_current_playlist();
          GRAMMOPHON.hide_status();

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
        }


    });

    Playdar.client.go();
  }
}

