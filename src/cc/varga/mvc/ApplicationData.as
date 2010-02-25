package cc.varga.mvc {
  import org.robotlegs.mvcs.*;
  import mx.collections.ArrayCollection;

  public class ApplicationData extends Actor {
    public static const MAX_RESULT_SETS : uint = 7; 
    [Bindable]
    public var results : ArrayCollection = new ArrayCollection();

    public function createNewResultContainer(label : String) : ArrayCollection {
      var container : ArrayCollection = new ArrayCollection();
      while (results.length >= MAX_RESULT_SETS) {
        results.source.shift();
      }
      results.addItem({"label": label, "content": container});
      return container;
    }

    
  }
}
