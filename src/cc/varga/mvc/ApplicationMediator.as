package cc.varga.mvc
{
	import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import cc.varga.utils.Logger;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var view : Grammophon;
		

		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void{	
      Logger.debug("Keyboard Event Mapping","ApplicationMediator");
   //   Logger.debug(view.);
      eventMap.mapListener(view, KeyboardEvent.KEY_UP, onKeyUp); 
		}
		
		private function onKeyUp(event : KeyboardEvent):void{
      Logger.debug("Keyboard Event KEY_UP","ApplicationMediator");
      dispatch(event);
		}
		
	}
}
