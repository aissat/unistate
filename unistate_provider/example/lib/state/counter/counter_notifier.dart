import 'package:flutter/foundation.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

class CounterProvider extends ChangeNotifier with UnistateNotifierMixin<int> {
  CounterProvider() : super();

  @override
  int get initialValue => 0;

  void decrement() {
    value--;
    // notifyListeners();
  }

  void increment() {
    value++;
    // notifyListeners();
  }
}
