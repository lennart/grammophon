package cc.varga.mvc.service {
  public interface IPlayerService {
    function set songId(sid : String) : void;
    function get songId() : String;
    function set beforeNext(callback : Function) : void;
    // Plays until 'beforeNext' doesn't set a new songId
    function enable () : void;
    // Will stop playing after end of current song, or immediately if flag is true
    function disable (immediate : Boolean = false) : void;
    // Will pause running song, or resumed zapped song
    function zap () : void;
  }
}
