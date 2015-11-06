package thx.fp;

import haxe.ds.Option;
import utest.Assert;
import thx.fp.Map;
using thx.fp.Maps;
import thx.Functions.*;
using thx.Arrays;
using thx.Ints;
import thx.Strings.*;

class TestMap {
  public function new() {}

  public function testEmpty() {
    var m : Map<String, Int> = Map.empty();
    Assert.same(None, m.get("some"));
    Assert.equals(0, m.size());
  }

  public function testSizes() {
    Assert.equals(3, Map.singleton("B", 1).set("A", 1).set("C", 1).size());
    Assert.equals(3, Map.singleton("A", 1).set("B", 1).set("C", 1).size());
    Assert.equals(3, Map.singleton("C", 1).set("B", 1).set("A", 1).size());
    Assert.equals(3, Map.singleton("B", 1).set("C", 1).set("A", 1).size());
    Assert.equals(3, Map.singleton("C", 1).set("A", 1).set("B", 1).size());
    Assert.equals(3, Map.singleton("A", 1).set("C", 1).set("B", 1).size());

    Assert.equals(1, Map.singleton("A", 1).set("A", 1).set("A", 1).size());
  }

  public function testFoldLeft() {
    var map = Map.singleton("A", 1).set("B", 2).set("C", 3);
    var arr = map.foldLeft([], function(arr, v) {
      arr.push(v);
      return arr;
    });
    Assert.same([1,2,3], arr.order(Ints.compare));
  }

  public function testFoldLeftKeys() {
    var map = Map.singleton("A", 1).set("B", 2).set("C", 3);
    var arr = map.foldLeftKeys([], function(arr, k) {
      arr.push(k);
      return arr;
    });
    Assert.same(["A","B", "C"], arr.order(compare));
  }

  public function testSet() {
    var m = Map.singleton("Y", 1).set("X", 2).set("Z", 3);
    Assert.same(Some(2), m.get("X"));
    Assert.same(Some(1), m.get("Y"));
    Assert.same(Some(3), m.get("Z"));
    Assert.equals(3, m.size());
  }

  public function testObjectSet() {
    var a = new CO("a"),
        b = new CO("b"),
        c = new CO("c"),
        m = Map
              .singleton(a, 1)
              .set(b, 2)
              .set(c, 3);
    Assert.same(Some(1), m.get(a));
    Assert.same(Some(2), m.get(b));
    Assert.same(Some(3), m.get(c));
    Assert.equals(3, m.size());
  }

  public function testObjectSet2() {
    var a = new CO2("a"),
        b = new CO2("b"),
        c = new CO2("c"),
        m = Map
              .singleton(a, 1)
              .set(b, 2)
              .set(c, 3);
    Assert.same(Some(1), m.get(a));
    Assert.same(Some(2), m.get(b));
    Assert.same(Some(3), m.get(c));
    Assert.equals(3, m.size());
  }
}

class CO {
  var v : String;
  public function new(v : String) this.v = v;
  public function compareTo(that : CO) : thx.Ord.Ordering
    return Strings.compare(v, that.v);
}

class CO2 {
  var v : String;
  public function new(v : String) this.v = v;
  public function compareTo(that : CO2) : Int
    return Strings.compare(v, that.v);
}
