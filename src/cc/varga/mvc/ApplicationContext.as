package cc.varga.mvc
{
  import flash.system.Security;
  import flash.events.KeyboardEvent;
	import cc.varga.mvc.commands.*;
	import cc.varga.mvc.service.*;
	import cc.varga.mvc.service.playlist.*;
	import cc.varga.mvc.views.navigation.*;
	import cc.varga.mvc.views.player.*;
	import cc.varga.mvc.views.result.ResultItem;
	import cc.varga.mvc.views.result.ResultItemMediator;
	import cc.varga.mvc.views.search.SearchSite;
	import cc.varga.mvc.views.search.SearchSiteEvent;
	import cc.varga.mvc.views.search.SearchSiteMediator;
	import cc.varga.mvc.service.api.PlaydarService;
	import cc.varga.mvc.service.ISearchService;
	import cc.varga.mvc.service.ISoundService;
	import flash.display.DisplayObjectContainer;
  import cc.varga.mvc.service.DisorderStylePlayer;
	
	import org.robotlegs.mvcs.Context;

	public class ApplicationContext extends Context
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup() : void{
				
			commandMap.mapEvent(SearchSiteEvent.DRAW_RESULT, DrawResultCommand, SearchSiteEvent);
			commandMap.mapEvent(NavigationEvent.LEFT_CLICK, NavigationCommand, NavigationEvent);
			commandMap.mapEvent(NavigationEvent.RIGHT_CLICK, NavigationCommand, NavigationEvent);
			commandMap.mapEvent(PlaylistEvent.PLAYLIST_ADD, AddToPlaylistCommand, PlaylistEvent);
      commandMap.mapEvent(KeyboardEvent.KEY_DOWN, KeyboardControlCommand, KeyboardEvent);
			
			mediatorMap.mapView(SearchSite, SearchSiteMediator);
			mediatorMap.mapView(ResultItem, ResultItemMediator);
			mediatorMap.mapView(Navigator, NavigationMediator);
			mediatorMap.mapView(Player, PlayerMediator);
			mediatorMap.mapView(PlayerItem, PlayerItemMediator);
			mediatorMap.mapView(Grammophon, ApplicationMediator);
      mediatorMap.createMediator(contextView);
			
			injector.mapSingletonOf(IPlaylistService, PlaylistService);
			injector.mapSingleton(StateChangerService);
      injector.mapSingleton(ApplicationData);
			injector.mapValue(Grammophon, contextView);
      injector.mapSingletonOf(IPlayerService, DisorderStylePlayer);
			injector.mapSingletonOf(ISearchService, PlaydarService);
			injector.mapSingletonOf(ISoundService, PlaydarService);
			
			super.startup();
			
		}
		
	}
}
