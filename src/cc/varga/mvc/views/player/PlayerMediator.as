package cc.varga.mvc.views.player
{
	import cc.varga.mvc.service.playlist.*;
	import cc.varga.mvc.views.result.*;
	import cc.varga.utils.Logger;
	
	import org.robotlegs.mvcs.Mediator;
	import cc.varga.mvc.service.api.PlaydarService;
	import cc.varga.mvc.service.*;
	
	public class PlayerMediator extends Mediator
	{
		
		
    [Inject]
    public var disorder : IPlayerService;

    [Inject]
    public var playlist : IPlaylistService;

    [Bindable]
    public var currentTrack : String;
		
		[Inject]
		public var view : Player;
		
		private var paused : Boolean = false;
		
		public function PlayerMediator()
		{
			super();
		}
		
		override public function onRegister() : void{
			eventMap.mapListener(view, PlayerEvent.PLAYER_ENABLE, onPlayPlaylist);
			eventMap.mapListener(view, PlayerEvent.PLAYER_PAUSE, onPause);
			eventMap.mapListener(view, PlayerEvent.PLAYER_NEXT, onNext);
			eventMap.mapListener(view, PlayerEvent.PLAYER_PREV, onPrev);

			
      disorder.beforeNext = onSongComplete;
      view.currently_playing.text = currentTrack;
			drawPlaylist();	
			
		}
		
		private function onPause(event:PlayerEvent):void{
      Logger.debug("Pause Event");
      disorder.zap();
		}
		
		private function onNext(event:PlayerEvent):void{
      disorder.disable(true);
      feedPlayer(playlist.next);
      disorder.enable();
      bindCurrentTrack();
		}

    private function onPrev(event:PlayerEvent) :void {
      disorder.disable(true);
      feedPlayer(playlist.prev);
      disorder.enable();
      bindCurrentTrack();
    }

		private function onSongComplete(): void{
      feedPlayer(playlist.next);
		}

    private function feedPlayer(song : Object) : void {
      if(song != null) {
        disorder.songId = song.sid;
      }
      else {
        disorder.disable();
      }
    }
		
		private function onPlayItem(event : PlayerEvent):void{
			Logger.log("PlayItem Event", "");
		}
		
		private function onPlayPlaylist(event : PlayerEvent):void{
      disorder.enable();
      bindCurrentTrack();
		}
    
    private function bindCurrentTrack() : void {
      if ((currentTrack == null) && (playlist.current != null)) {
        currentTrack = playlist.current.track;
      }
    }
		
		private function onPlayMP3(event:PlayerEvent) : void {
		}
		
		private function drawPlaylist():void{
			view.dg.dataProvider = playlist.all;
			/*view.playlist.removeAllElements();
			
			for(var i:uint=0; i < playlist.all.length; i++){
				
				var item : PlayerItem = new PlayerItem();
				item.jsonObj = playlist.all.getItemAt(i);
				item.position = i;
				view.playlist.addElement(item);
				
			}*/
			
		}
		
	}
}
