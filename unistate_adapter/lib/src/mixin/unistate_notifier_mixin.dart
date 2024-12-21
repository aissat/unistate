import 'package:flutter/foundation.dart';

/// Mixin for ChangeNotifier based classes
mixin UnistateNotifierMixin<T> on ChangeNotifier implements ValueListenable<T> {
  T? _value;
  T get initialValue;

  @override
  T get value => _value ??= initialValue;

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}
