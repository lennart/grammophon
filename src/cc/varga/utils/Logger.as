package cc.varga.utils
{
	import flash.utils.getTimer;

	public class Logger
	{
    public static var verbose : Boolean = true;
		public function Logger()
		{
		}
		
		public static function log(message : String, classpath:String):void{
			trace("["+getTimer()+"]["+classpath+"] --> " + message);
		}

    public static function debug(message : *, classpath:String = "DEBUG") : void {
      if(verbose) {
      log(message, classpath);
      }
    }
		
	}
}
