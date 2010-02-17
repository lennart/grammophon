package <%= package_name %> 
{
  import flash.events.Event;

  public class <%= class_name %>Event extends Event
  {
    /*
     * Sample Constants and instance variables for Event
     */
		//public static const <%= class_name.underscore.upcase %>_ACTION_COMPLETE : String = "<%= class_name.underscore %>_action_complete";
		//public var data : Object;    

    public function <%= class_name %>Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
      super(type, bubbles, cancelable);
    }
  }
}
