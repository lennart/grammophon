package cc.varga.mvc.service.playlist
{
	import org.robotlegs.mvcs.Actor;
	import mx.collections.ArrayCollection;
	
	public class Playlist extends Actor implements IPlaylist
	{
		[Bindable]
		private var playlist : ArrayCollection = new ArrayCollection();		
		
		public function Playlist()
		{
			super();
		}
		
		public function addToPlaylist(item : Object):void
		{
			playlist.addItem(item);
		}
		
		public function removeFromPlaylist(item : Object):void
		{
			
		}
		
		public function shufflePlaylist():void
		{
		}
		
		public function repeatPlaylist():void
		{
		}
		
		public function removeAll():void
		{
			
		}
		
		public function getAll():ArrayCollection
		{
			return playlist;
		}
	}
}