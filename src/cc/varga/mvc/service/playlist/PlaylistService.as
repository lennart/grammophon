package cc.varga.mvc.service.playlist
{
	import cc.varga.mvc.service.IPlaylistService;
	import cc.varga.utils.Logger;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PlaylistService extends Actor implements IPlaylistService
	{
		[Bindable]
		private var playlist : ArrayCollection = new ArrayCollection();		
		
		[Bindable]
		public var repeat : Boolean = false;
		
		private var itemDict : Dictionary = new Dictionary();
		private var currentPos : uint = 0;
    private var _current : Object;
		public function PlaylistService()
		{
			super();
		}
		
    public function get current() : Object {
      return _current;
    }


		public function add(item : Object) : void
		{
			playlist.addItem(item);
			itemDict[item] = item;
		}
		
		public function remove(item : Object) : void
		{
			
		}
		
		public function clear() : void
		{
			playlist = new ArrayCollection();
			itemDict = new Dictionary();
		}
		
		public function get prev() : Object{
      Logger.debug("Fetching previous Song\nCurrent Position: "+currentPos);
      if(currentPos > 1) {
        currentPos -= 1;
        _current = playlist.getItemAt(currentPos);
        return current;
      }
      else {
        return null;
      }
		}
		
		public function get next() : Object{
      Logger.debug("Fetching next Song\nCurrent Position: "+currentPos);
      if(currentPos < playlist.length) {
        _current = playlist.getItemAt(currentPos++);
        return current; 
      }
      else {
        return null;
      }
		}
		
		public function get all() : ArrayCollection
		{
			return playlist;
		}
		


	}
}

