package cc.varga.mvc.views.browser {
  import flash.events.Event;

  public class BrowserEvent extends Event {
		public static const ARTIST_SELECTED : String = "artist_selected";
		
	  public var content : Object;

		public function BrowserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

  }
}
