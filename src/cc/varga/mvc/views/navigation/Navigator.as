package cc.varga.mvc.views.navigation {
  import spark.components.supportClasses.SkinnableComponent;
  import flash.events.MouseEvent;

  public class Navigator extends SkinnableComponent {
    [Bindable]
    public var label : String;



			public function leftButton_clickHandler(event:MouseEvent):void
			{
				var naviEvent : NavigationEvent = new NavigationEvent(NavigationEvent.LEFT_CLICK);
				dispatchEvent(naviEvent);
			}


			public function rightButton_clickHandler(event:MouseEvent):void
			{
				var naviEvent : NavigationEvent = new NavigationEvent(NavigationEvent.RIGHT_CLICK);
				dispatchEvent(naviEvent);
			}
  }
}
