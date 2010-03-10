/*
* This source is heavily based on Lucas Hrabovsky (imlucas) as3playdar.
* The Original Source can be found at http://github.com/imlucas/as3playdar/blob/master/src/org/playdar/Playdar.as
*/
package cc.varga.mvc.service.api {
	import cc.varga.mvc.service.ISearchService;
	import cc.varga.mvc.service.ISoundService;
  import com.adobe.serialization.json.JSON;
	import cc.varga.utils.logger.ILogger;
	import cc.varga.utils.logger.Logger;
  import org.playdar.Playdar;
  import org.robotlegs.mvcs.Actor;
  import cc.varga.mvc.views.player.PlayerEvent;
  import cc.lmaa.yajl.Yajl;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import mx.collections.ArrayCollection;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLVariables;
	
    
	public class ETunesService extends Actor  {
    private var logger : ILogger = new Logger("ETunesService");
    private var _currentlyPlaying : String;
    private var _onComplete : Function;
    private var _onError : Function;
    private const _rootURL : String = "http://localhost:5984/etunes/_design/etunes-app/_view/";

    public function ETunesService() {
//      playdar = new Playdar();
      super();
    }

    public function artists(onComplete : Function) : void {
      var query : URLVariables = new URLVariables();
      query.reduce = true;
      query.group_level = 1;
      getData(_rootURL+"artist", function(data : Object) { onArtistsComplete(onComplete,data); }, onIOError, query);
    }

    public function tracks(filter : Object, onComplete : Function) : void {
      var query : URLVariables = new URLVariables();
      if(filter.artist != null) {
        query.key = JSON.encode(filter.artist);
        query.include_docs = true;
        query.reduce = false;
        getData(_rootURL+"artist", function(data : Object) { 
          onTracksComplete(onComplete, data); 
            }, onIOError, query);
      }
      else {
        logger.error("There is nothing inside the filter I can work with");
      }
    }
    
    protected function onTracksComplete(callback : Function, data : Object) : void {
      logger.debug("Got Tracks");
      callback(new ArrayCollection( (data["rows"] as Array).map(filterDocs) ));
    }

    protected function onArtistsComplete(callback : Function, data : Object) : void {
      logger.debug("Got Response");
      callback(new ArrayCollection((data["rows"] as Array).map(wrapAsArtist(filterKeys))));
    }

    protected function onIOError(e : Error) : void {
      logger.error("Failed to load data");
    }

    protected function getData(url:String, onSuccess:Function, onError:Function=null, requestParams:Object=null):void{
      var request:URLRequest;

      request = new URLRequest(url);
      if(requestParams!=null){
        request.data = requestParams as URLVariables;
      }
      var loader:URLLoader = new URLLoader();
      loader.addEventListener(
          IOErrorEvent.IO_ERROR, 
          function(e:IOErrorEvent):void{
          var error:Error = new Error("IOError: Is the Couch acually running?");
          if(onError != null){
          onError(error);
          }
          }
          );
      loader.addEventListener(
          Event.COMPLETE, 
          function(e:Event):void{
          var loader:URLLoader = e.target as URLLoader;
          try{
          var parsed:Object = JSON.decode(loader.data);
          }
          catch(e:Error){
          if(onError != null){
          onError(e);
          }
          }
          onSuccess(parsed);
          }
          );
      loader.load(request);
    }

    private function filterDocs(item : *, index : int, array : Array) : Object {
      return item["doc"];
    }

    private function wrapAsArtist(filterFunction : Function) : Function {
      return function(item : *, index : int, array : Array) { return {"artist" : filterFunction(item,index,array)}; };
    }

    private function filterKeys(item : *, index : int, array : Array) : Object {
      return item["key"];
    }
  }

}

