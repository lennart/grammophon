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
      var nickname : String = event.search_query.nickname;
      var loader : URLLoader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, function(response:Event) : void {
        onBlipsFetched(nickname, response); 
      });
      loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      loader.load(new URLRequest("http://api.blip.fm/blip/getUserProfile.json?username="+nickname));
    }

    private function onBlipsFetched(label : String, event : Event) : void {
      var json : Array  = Yajl.decode(event.currentTarget.data).result.collection.Blip as Array;
      resultContainer[label] = appData.createNewResultContainer(label, json.length);
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);
      searchEvent.resultSetLabel = label;
      dispatch(searchEvent);
      for(var i : uint; i < json.length; i++) {
        playdar.resolve(json[i].artist, json[i].title, function(response:Object) {
          onSearchResults(label, response, false); 
        }, onError);
      }
    }

    private function onSearchClicked(event : SearchSiteEvent):void {
      // Setting both artist and track to search_query
      var artist:String = event.search_query.artist;
      var track:String = event.search_query.title;
      var label : String = artist+" "+track;
      playdar.resolve(artist, track, function(response:Object) : void { 
        onSearchResults(label, response); 
        }, onError); 

      Logger.log("Fetching Search Results",this.toString());
      resultContainer[label] = appData.createNewResultContainer(label);
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);
      searchEvent.resultSetLabel = label;
      dispatch(searchEvent);
    }

    private function onSearchResults(label : String, response:Object, addAll : Boolean = true) : void {
      Logger.log("Search Results coming in: "+response.results.length,this.toString());
      if(addAll) {
        resultContainer[label].addAll(new ArrayCollection(response.results));
      }
      else {
        resultContainer[label].addItem(response.results[0]);
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

