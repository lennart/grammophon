package cc.varga.mvc {
  import org.robotlegs.mvcs.*;
  import mx.collections.ArrayCollection;
  import mx.collections.ArrayList;

  public class ApplicationData extends Actor {
    public static const MAX_RESULT_SETS : uint = 7; 
    [Bindable]
      public var results : Object = new Object();

    [Bindable]
      public var latestResultSet : ArrayCollection;

    public function createNewResultContainer(uid : String, label : String, maxSize : uint = 0) : ArrayCollection {
      var container : ArrayCollection = new ArrayCollection();
      while (results.length >= MAX_RESULT_SETS) {
        results.source.shift();
      }
      if (maxSize != 0) {
        results[uid] =  {"uid" : uid, "label": label, "maxSize" : maxSize, "content" :container};
      }
      else {
        results[uid] = {"uid" : uid, "label": label, "content": container};
      }
      latestResultSet = results[uid];
      return container;
    }
    
    public function get resultsArrayList() : ArrayList {
      var list : ArrayList = new ArrayList();
      for(var result : Object in results) {
        list.addItem(result);
      }
      return list;
    }

  }
}
