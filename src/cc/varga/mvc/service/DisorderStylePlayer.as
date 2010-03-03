package cc.varga.mvc.service
{
  import cc.varga.mvc.views.player.PlayerEvent;
  import flash.events.Event;	
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import org.robotlegs.mvcs.*;


  import cc.varga.utils.Logger;
  import cc.varga.mvc.service.*;

  public class DisorderStylePlayer extends Actor implements IPlayerService
  {
    public static const CONTINUOUS : String = "continuous";
    public static const STALLED : String = "stalled";
    public static const ZAPPED : String = "zapped";


    [Inject]
      public var playdar : ISoundService;

    private var _state : String = STALLED;


    private var _current : String;
    private var _beforeNext : Function;
    private var _enabled : Boolean = false;



    public function DisorderStylePlayer()
    {
      super();
    }

    public function set songId(sid : String) : void{
      if((sid != "") && (sid != null)) {
        _current = sid;
      }
    }

    protected function get state() : String {
      return _state;
    }

    protected function set state(newState : String) {
      if (newState != _state) {
        _state = newState;
      }
      else {
        Logger.debug("State Unchanged:"+_state);
      }
    }

    private function handleState() : void {
      switch(state) {
        case CONTINUOUS:
          if(canPlay) {
            playdar.play(_current, triggerCallback, onFailure);
          }
          else {
            onFailure(new Error("No Song Selected"));
          }
          break;
        case STALLED:
          Logger.log("Stopping Playback","Disorder Style Player");
          playdar.stop();
          break;
        case ZAPPED:
          state = CONTINUOUS;
          playdar.resume();
          break;
      }
    }

    public function zap() : void {
      if(state != ZAPPED) {
        playdar.pause();
      }
      else {
        state = ZAPPED;
      }
    }

    public function enable() : void { 
      if(!_enabled) {
        _enabled = true;
        state = CONTINUOUS;
        handleState();
      }
      else {
        Logger.debug("Already enabled");
      }
    }

    protected function triggerCallback() : void {
      if(canGetNext) {
        _beforeNext();
      }
      handleState();
    }

    public function disable(immediate : Boolean = false) : void {
      state = STALLED;
      if(immediate) {
        handleState();
      }
      _enabled = false;
    }

    private function onFailure(e : *) : void {
      Logger.debug("Decide what to do when playing fails, in this case we just skip to the next");
      triggerCallback();
    }

    public function get songId() : String {
      return _current;
    }

    private function get canPlay() : Boolean {
      return (songId != null);
    }

    private function get canGetNext() : Boolean {
      return (_beforeNext != null);
    }

    public function set beforeNext(callback : Function) : void {
      _beforeNext = callback;
    }
  }
}
