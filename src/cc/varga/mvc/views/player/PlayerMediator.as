package cc.varga.mvc.views.player
{
	import org.robotlegs.mvcs.Mediator;
	import cc.varga.mvc.service.playlist.*;
	import cc.varga.mvc.views.result.*;
	
	public class PlayerMediator extends Mediator
	{
		
		[Inject]
		public var playlistModel : PlaylistService;
		
		[Inject]
		public var view : Player;
		
		public function PlayerMediator()
		{
			super();
		}
		
		override public function onRegister() : void{
			
			eventMap.mapListener(eventDispatcher, PlayerEvent.PLAY_YOUTUBE_VIDEO, playYouTubeVideo);
			
			drawPlaylist();	
			
		}
		
		private function playYouTubeVideo(event:PlayerEvent):void{
		
			view.youtubePlayer.videoID = event.youTubeID;
			
		}
		
		private function drawPlaylist():void{
			
			view.playlist.removeAllElements();
			
			for(var i:uint=0; i < playlistModel.getAll().length; i++){
			
				var item : ResultItem = new ResultItem();
				item.jsonObj = playlistModel.getAll().getItemAt(i);
				view.playlist.addElement(item);
				
			}
			
		}
		
	}
}