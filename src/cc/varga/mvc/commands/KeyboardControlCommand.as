package cc.varga.mvc.commands
{
	import org.robotlegs.mvcs.Command;
	import cc.varga.mvc.views.navigation.*;
	import cc.varga.mvc.*;
	import cc.varga.utils.*;
	import cc.varga.mvc.service.*;
  import flash.ui.Keyboard;
  import flash.events.KeyboardEvent;
	
	public class KeyboardControlCommand extends Command
	{
		
		[Inject]
		public var event : KeyboardEvent;

		
		private var mainView : Grammophon;
		
		public function KeyboardControlCommand()
		{
			super();
		}
		
		override public function execute():void{
		  Logger.debug("Incoming Keyboard Event");	
			mainView = contextView as Grammophon;
			
      if(event.ctrlKey) {
        switch(event.keyCode){
          case Keyboard.LEFT :
            dispatch(new NavigationEvent(NavigationEvent.LEFT_CLICK));
            break;
          case Keyboard.RIGHT:
            dispatch(new NavigationEvent(NavigationEvent.RIGHT_CLICK));
            break;
          default :
            break;
        }
      }
		}
		
	}
}
