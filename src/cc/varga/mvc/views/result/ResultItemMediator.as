package cc.varga.mvc.views.result
{
	import cc.varga.mvc.*;
	import cc.varga.mvc.service.StateChangerService;
	import cc.varga.mvc.service.playlist.PlaylistEvent;
	import cc.varga.mvc.service.*;
	import cc.varga.mvc.views.player.*;
	
	import org.robotlegs.mvcs.Mediator;
  import cc.varga.utils.Logger;
  import mx.collections.ArrayCollection;
  import cc.varga.mvc.ApplicationData;
	
	public class ResultItemMediator extends Mediator
	{
		[Inject]
		public var view : ResultItem;
		
		[Inject]
		public var model : IPlaylistService;
		
		[Inject]
		public var stateService : StateChangerService;

    [Inject]
    public var appData : ApplicationData;

    [Bindable]
    public var currentResultSet : Object;

    [Bindable]
    public var state : String;
		
		public function ResultItemMediator() { super(); }
		
		override public function onRegister() : void{
      Logger.log("Registered","Result Mediator");
			eventMap.mapListener(view, PlaylistEvent.PLAYLIST_ADD, onAddToPlaylist);   
			eventMap.mapListener(view, ResultItemEvent.PLAY_ITEM, onPlay);
			eventMap.mapListener(view, ResultItemEvent.SWITCH_TO_RESULTS, onSwitchToResults);
			eventMap.mapListener(eventDispatcher, ResultItemEvent.SWITCH_TO_RESULTS, onSwitchToResults);
      //eventMap.mapListener(eventDispatcher, ResultItemEvent.DRAW_RESULTS, drawResults);
      if (currentResultSet == null) {
        currentResultSet = appData.latestResultSet;
      }
      setDataGridProvider();
      view.resultsChooser.dataProvider = appData.resultsArrayList;
		}

/*    private function drawResults(event : ResultItemEvent) : void {
      Logger.log("Drawing Results","Result Mediator");
      view.dg.dataProvider = event.result;
    }*/

    private function setDataGridProvider() : void {
      if(currentResultSet != null) {
        view.dg.dataProvider = currentResultSet.content;
      }
    }
	
    private function onSwitchToResults(event : ResultItemEvent) : void {
      Logger.debug("Switching to Results");
      currentResultSet = appData[event.uid];
      setDataGridProvider();
      if(currentResultSet.maxSize != 0) {
        view.maxSize.text = currentResultSet.maxSize;
      }
      else {
        view.maxSize.text = "";
      }
    }

    private function onPlay(event : ResultItemEvent):void{
      /* Currently this does nothing, however, it might one day be able to fade out current
       * playlist, backup it, fade in song (possible in the middle), restore current playlist and 
       * continue on pause of this result
       */
      //stateService.switchToStage(ApplicationStateList.PLAYER_STATE);
      //var playerEvent : PlayerEvent = new PlayerEvent(PlayerEvent.PLAY_YOUTUBE_VIDEO);
      //playerEvent.result = event.result;
      //dispatch(playerEvent);
    }

    private function onAddToPlaylist(event : PlaylistEvent):void{
      dispatch(event);			
    }

  }
}
