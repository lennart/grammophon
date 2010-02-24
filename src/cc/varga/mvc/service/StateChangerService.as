package cc.varga.mvc.service
{
  import cc.varga.mvc.*;
  import cc.varga.utils.Logger;

  import flash.events.Event;
  import flash.events.IEventDispatcher;

  import flashx.textLayout.tlf_internal;

  import mx.events.StateChangeEvent;

  import org.robotlegs.mvcs.Actor;

  public class StateChangerService extends Actor
  {

    [Inject]
      public var contextView : Grammophon;

    private var stateList : Array = ApplicationStateList.stateList;
    private var currentPos : int = 0;

    public function StateChangerService(){ super(); }

    public function switchToStage(state : String, callBack : Function = null):void{
      updateCurrentPosition(state);
      updateCurrentState();
      if(callBack != null){
        callBack();
      }
    }

    public function switchToLeft():void{
      currentPos--;
      currentPos = (stateList.length + currentPos) % stateList.length;

      updateCurrentState();
    }

    public function switchToRight():void{
      currentPos++;
      currentPos =  currentPos % stateList.length;

      updateCurrentState();
    }
    private function updateCurrentPosition(state : String) : void {
      currentPos = stateList.indexOf(state);
    }

    private function updateCurrentState() : void {
      Logger.debug("Switching to "+stateList[currentPos]);
      contextView.currentState = stateList[currentPos];
    }
  }
}
