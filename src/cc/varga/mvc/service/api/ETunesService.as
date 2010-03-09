/*
* This source is heavily based on Lucas Hrabovsky (imlucas) as3playdar.
* The Original Source can be found at http://github.com/imlucas/as3playdar/blob/master/src/org/playdar/Playdar.as
*/
package cc.varga.mvc.service.api {
	import cc.varga.mvc.service.ISearchService;
	import cc.varga.mvc.service.ISoundService;
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
    public function ETunesService() {
//      playdar = new Playdar();
      super();
    }

    public function artists(onComplete : Function) : void {
      var query : URLVariables = new URLVariables();
      query.reduce = true;
      query.group_level = 1;
      getData("http://localhost:5984/etunes/_design/etunes-app/_view/artist", function(data : Object) { onArtistsComplete(onComplete,data); }, onIOError, query);
    }

    protected function onArtistsComplete(callback : Function ,data : Object) : void {
      logger.debug("Got Response");
      callback(new ArrayCollection(data["rows"] as Array));
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
          var parsed:Object = Yajl.decode(loader.data);
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
    //   public function resolve(artist : String,track : String, onSuccess : Function, onError : Function) : void {
    //      playdar.resolve(artist, track, onSuccess, onError);
    //    }
    //
    //    public function play(uid : String, onComplete : Function, onError : Function) : void {
    //      _onComplete = onComplete;
    //      _onError = onError;
    //      playdar.play(uid, onSongComplete, onError);
    //      _currentlyPlaying = uid;
    //    }
    //
    //    public function resume() : void {
    //      Logger.debug("Resume called for: "+_currentlyPlaying);
    //      playdar.resume(_currentlyPlaying);
    //    }
    //
    //    public function stop() : void {
    //      Logger.debug("Stop called for: "+_currentlyPlaying);
    //      playdar.stop(_currentlyPlaying);
    //    }
    //    
    //    public function pause() : void {
    //      Logger.debug("Pause called for: "+_currentlyPlaying);
    //      playdar.pause(_currentlyPlaying);
    //    }
    //
    //    private function onSongComplete(event : Event) : void {
    //      playdar.stop(_currentlyPlaying);
    //      if (_onComplete != null) {
    //        _onComplete();
    //      }
    //    }
    //
    //    private function onError(event : Event) : void {
    //      Logger.log("Something failed: "+event.toString(),"ETunesService");
    //      if (_onError != null) {
    //        _onError();
    //      }
    //    }

  }

}

