import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin for Cubit based classes
mixin UnistateCubitMixin<State> on Cubit<State>
    implements ValueListenable<State> {
  final List<VoidCallback> _listeners = [];

  @override
  State get value => state;

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
    stream.listen((_) {
      for (var listener in _listeners) {
        listener();
      }
    });
  }

  @override
  Future<void> close() {
    _listeners.clear();
    return super.close();
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }
}
