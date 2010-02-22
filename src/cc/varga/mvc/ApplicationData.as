package cc.varga.mvc {
  import org.robotlegs.mvcs.*;
  import mx.collections.ArrayCollection;

  public class ApplicationData extends Actor {
    
    [Bindable]
    public var results : ArrayCollection = new ArrayCollection();

    public function createNewResultContainer(label : String) : ArrayCollection {
      var container : ArrayCollection = new ArrayCollection();
      results.addItem({"label": label, "content": container});
      return container;
    }

    
  }
}
