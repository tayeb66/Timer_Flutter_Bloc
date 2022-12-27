import 'package:flutter/scheduler.dart';

class Ticker1 {
  const Ticker1();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
