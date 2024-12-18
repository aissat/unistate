import 'package:flutter/foundation.dart';
// import 'auto_dispose_mixin.dart';

/// Mixin for ChangeNotifier based classes
mixin UnistateNotifierMixin<T> on ChangeNotifier implements ValueListenable<T> {
  T get initialValue;
  T? _value;

  @override
  T get value => _value ??= initialValue;

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // AutoDisposeMixin.dispose();
  }
}
