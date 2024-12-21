import 'package:flutter/foundation.dart';

/// Mixin for classes that need to implement ValueListenable
mixin UnistateListenableMixin<T> implements ValueListenable<T> {
  final List<VoidCallback> _listeners = [];

  @override
  T get value;

  @override
  VoidCallback addListener(VoidCallback listener) {
    _listeners.add(listener);
    return () {
      removeListener(listener);
    };
  }

  void notifyListeners() {
    for (var listener in List.of(_listeners)) {
      listener();
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }
}
