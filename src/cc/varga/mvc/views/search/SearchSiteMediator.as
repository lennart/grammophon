package cc.varga.mvc.views.search
{
  import cc.varga.api.jukebox.IRESTful;
  import cc.varga.api.jukebox.JukeboxAPIEvent;
  import cc.varga.api.jukebox.JukeboxAPIVO;
  import cc.varga.api.jukebox.JukeboxAPIConfig;
  import cc.varga.api.jukebox.services.JukeboxService;
  import cc.varga.mvc.service.ISearchService;
  import cc.varga.mvc.ApplicationData;
  import cc.varga.utils.Logger

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
      public var config : JukeboxAPIConfig;

    [Inject]
      public var appData : ApplicationData;

    private var searchService : IRESTful; 
    private var blipService : IRESTful; 
    private var leftToResolve : uint;
    private var resultContainer : Object = new Object();

    public function SearchSiteMediator()
    {
      super();
    }

    override public function onRegister() : void{
      eventMap.mapListener(view, SearchSiteEvent.SEARCH_CLICKED, onSearchClicked);
      eventMap.mapListener(view, SearchSiteEvent.LOAD_BLIP_FM_FEED, onLoadBlipFmFeed);
    }

    private function onFaultService(vo: JukeboxAPIVO):void{
      Alert.show("OnFaultService: " + vo);
    }

    private function onLoadBlipFmFeed(event : SearchSiteEvent):void{
      var vo:JukeboxAPIVO = new JukeboxAPIVO(config, {type: JukeboxAPIVO.BLIP_TYPE, path: [event.blipFM_Nick], format: ""});
      createAndRegisterService(vo,onFaultService,resolveResults).fetch();
    }

    private function resolveResults(vo : JukeboxAPIVO) : void {
      Logger.debug("Resolving Blips",this.toString());
      var blips:Array = vo.data as Array;
      var label : String = vo.path[0];
      resultContainer[label] = appData.createNewResultContainer(label);
      leftToResolve = blips.length;
      Logger.debug("Left to resolve: "+leftToResolve, this.toString());

      for(var i:uint = 0; i < blips.length; i++) {
        var blip:Object = blips[i];
        if((blip.artist == "") || (blip.artist == null)) {
          blip.artist = blip.title
        }
        Logger.debug("resolve: "+blip.title, this.toString());
        playdar.resolve(blip.artist,blip.title,function(response: Object) : void { onResolvedBlip(label, response); },onUnresolvedBlip);
      }

        var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);
        searchEvent.resultSetLabel = label;
        dispatch(searchEvent);
    }

    private function onUnresolvedBlip(response : Object) : void {
      leftToResolve -= 1;
      if(leftToResolve == 0) {

        Logger.log("Resolving complete",this.toString());
      }
      else {
        Logger.debug("Unresolved Blip "+leftToResolve+" left to go",this.toString());
      }
    }

    private function onResolvedBlip(label : String, response : Object) : void {
      leftToResolve -= 1;
      resultContainer[label].addItem(response.results[0]);
      if(leftToResolve == 0) {
        Logger.log("Resolving complete",this.toString());
      }
      else {
        Logger.debug("Resolved Blip "+leftToResolve+" left to go",this.toString());
      }
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

    private function createAndRegisterService(vo: JukeboxAPIVO, fault: Function, complete: Function) : IRESTful {
      var service:IRESTful = JukeboxService.createService(vo);
      service.faultCallback = fault;
      service.completeCallback = complete;
      return service;
    }

    private function onError(e : Error) : void {
      Logger.log("Error: "+e.toString(), this.toString());
    }

    private function drawResult(vo: JukeboxAPIVO):void{
      var searchEvent : SearchSiteEvent = new SearchSiteEvent(SearchSiteEvent.DRAW_RESULT);
      searchEvent.result = vo.data;
      dispatch(searchEvent);
    }

    public function toString() : String {
      return "Search Site Meditator";
    }

  }
}

