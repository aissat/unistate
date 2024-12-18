import 'package:flutter/foundation.dart';

/// Mixin to make any state holder compatible with ValueListenable
mixin UnistateListenableMixin<T> implements ValueListenable<T> {
  T get currentState;
  @override
  void addListener(VoidCallback listener);
  @override
  void removeListener(VoidCallback listener);

  @override
  T get value => currentState;
} 