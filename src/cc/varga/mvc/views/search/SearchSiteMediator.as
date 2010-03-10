package cc.varga.mvc.views.search
{
  import cc.varga.mvc.service.ISearchService;
  import cc.varga.mvc.ApplicationData;
  import cc.varga.utils.Logger;
  import flash.events.KeyboardEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import cc.lmaa.yajl.Yajl;
  import flash.ui.Keyboard;


  import mx.collections.ArrayCollection;
  import mx.utils.UIDUtil;
  import mx.controls.Alert;

  import org.robotlegs.mvcs.Mediator;

  public class SearchSiteMediator extends Mediator
  {

    [Inject]
      public var view : SearchSite;

    [Inject]
      public var playdar : ISearchService;

    [Inject]
      public var appData : ApplicationData;

    private var leftToResolve : uint;
    private var resultContainer : Object = new Object();

    public function SearchSiteMediator()
    {
      super();
    }

    override public function onRegister() : void{
      eventMap.mapListener(view, SearchSiteEvent.SEARCH_CLICKED, onSearchClicked);
      eventMap.mapListener(view, SearchSiteEvent.FETCH_BLIPS, onFetchBlips);
    }

    private function onFetchBlips(event : SearchSiteEvent) : void {
      var label : String = labelForContainer(event.search_query);
      var loader : URLLoader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, function(response:Event) : void {
        onBlipsFetched(label, response); 
      });
      loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      loader.load(new URLRequest("http://api.blip.fm/blip/getUserProfile.json?username="+event.search_query.nickname));
    }

    private function onBlipsFetched(label : String, event : Event) : void {
      var uid : String = UIDUtil.createUID();
      var json : Array  = Yajl.decode(event.currentTarget.data).result.collection.Blip as Array;
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);

      resultContainer[uid] = appData.createNewResultContainer(uid, label, json.length);
      searchEvent.resultSetUID = uid;
      dispatch(searchEvent);

      for(var i : uint; i < json.length; i++) {
        resolveQuery(json[i], uid, false);
      }
    }

    private function onSearchClicked(event : SearchSiteEvent):void {
      var label : String = labelForContainer(event.search_query);
      var uid : String = UIDUtil.createUID();
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);

      Logger.log("Fetching Search Results",this.toString());
      resolveQuery(event.search_query, uid);
      resultContainer[uid] = appData.createNewResultContainer(uid, label);
      searchEvent.resultSetUID = uid;

      dispatch(searchEvent);
    }

    private function labelForContainer(queryObject : Object) : String {
      var labelComponents : Array = [];
      if(queryObject.nickname != null) {
        labelComponents.push(queryObject.nickname);
      }
      if(queryObject.artist != null) {
        labelComponents.push(queryObject.artist);
      }
      if(queryObject.track != null) {
        labelComponents.push(queryObject.track);
      }
      return labelComponents.join(" - ");
    }

    private function resolveQuery(queryObject : Object, uid : String, addAll : Boolean = true) : void {
      playdar.resolve(queryObject.artist, queryObject.track, function(response:Object) : void { 
        onSearchResults(uid, response, addAll); 
        }, onError); 
    }

    private function onSearchResults(uid : String, response:Object, addAll : Boolean = true) : void {
      Logger.log("Search Results coming in: "+response.results.length,this.toString());
      if(addAll) {
        resultContainer[uid].addAll(new ArrayCollection(response.results));
      }
      else {
        resultContainer[uid].addItem(response.results[0]);
      }
    }

    private function onIOError(e : IOErrorEvent) : void {
      Logger.log("Error: "+e.toString(), this.toString());
    }

    private function onError(e : Error) : void {
      Logger.log("Error: "+e.toString(), this.toString());
    }

    public function toString() : String {
      return "Search Site Meditator";
    }

  }
}

