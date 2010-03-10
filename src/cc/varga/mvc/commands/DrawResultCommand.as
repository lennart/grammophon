package cc.varga.mvc.commands
{
	import org.robotlegs.mvcs.Command;
	import cc.varga.mvc.ApplicationStateList;
	import mx.events.StateChangeEvent;
	import cc.varga.mvc.views.search.SearchSiteEvent;
	import cc.varga.mvc.views.result.ResultItem;
	import cc.varga.mvc.views.result.ResultItemEvent;

	import mx.events.FlexEvent;
	import mx.controls.Alert;
	import cc.varga.mvc.service.*;
  import spark.components.Label;
  import mx.collections.ArrayCollection;
  import cc.varga.utils.Logger;
  import cc.varga.mvc.ApplicationData;
	
	public class DrawResultCommand extends Command
	{
		[Inject]
		public var event : SearchSiteEvent;

    [Inject]
		public var stageService : StateChangerService;

    [Inject]
    public var appData : ApplicationData;
		
		private var resultArray : ArrayCollection;
		private var mainView : Grammophon;
		private var currentPos : uint = 0;
		
		public function DrawResultCommand(){ super(); }
		
		override public function execute() : void{
			mainView = contextView as Grammophon;
			
			stageService.switchToStage(ApplicationStateList.RESULT_STATE, drawResults);
    }
			
		private function drawResults(invocationEvent: * = null):void{
      Logger.debug("passing Results on","Draw Result Command");

      var itemEvent : ResultItemEvent = new ResultItemEvent(ResultItemEvent.SWITCH_TO_RESULTS);
      itemEvent.uid = invocationEvent.uid;
      dispatch(itemEvent);
		}
		
		private function onChanging(event : StateChangeEvent):void{
			
		}
		
	}
}
