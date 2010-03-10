package cc.varga.mvc.views.search
{
	import flash.events.Event;
	
	public class SearchSiteEvent extends Event
	{

		public static const SEARCH_CLICKED : String = "search_clicked";
		public static const FETCH_BLIPS : String = "fetch_blips";
		public static const DOWNLOAD_SONG : String = "download_song";
		public static const LOAD_REMOTE_PLAYLIST : String = "load_remote_playlist";
		public static const DRAW_RESULT : String = "draw_result";
		public static const POLL_COLLECTION : String = "poll_collection";
		
		public var search_query : Object;
		public var result : *;
    public var resultSetUID : String;
		
		public function SearchSiteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
