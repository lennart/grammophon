package cc.varga.mvc.views.search
{
  import cc.varga.mvc.service.ISearchService;
  import cc.varga.mvc.ApplicationData;
  import cc.varga.utils.Logger;
  import flash.events.KeyboardEvent;
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
    }

    private function onSearchClicked(event : SearchSiteEvent):void {
      Logger.log(event.toString(),this.toString());
      // Setting both artist and track to search_query
      var artist:String = event.search_query.artist;
      var track:String = event.search_query.title;
      var label : String = artist+" "+track;
      playdar.resolve(artist, track, function(response:Object):void{ onSearchResults(label, response); }, onError); 

      Logger.log("Fetching Search Results",this.toString());
      resultContainer[label] = appData.createNewResultContainer(label);
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);
      searchEvent.resultSetLabel = label;
      dispatch(searchEvent);
    }

    private function onSearchResults(label : String, response:Object) : void {
      Logger.log("Search Results coming in: "+response.results.length,this.toString());
      resultContainer[label].addAll(new ArrayCollection(response.results));
    }

    private function onError(e : Error) : void {
      Logger.log("Error: "+e.toString(), this.toString());
    }

    public function toString() : String {
      return "Search Site Meditator";
    }

  }
}

