import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Mixin for GetX based classes that implements ValueListenable
mixin UnistateGetxMixin<T extends Object?> on GetxController
    implements ValueListenable<T> {
  late final Rx<T> _rx;
  final List<VoidCallback> _listeners = [];
  Worker? _worker;

  @override
  T get value => _rx.value;

  set value(T newState) {
    _rx.value = newState;
    // print('emitted: $newState');
  }

  @override
  VoidCallback addListener(VoidCallback listener) {
    // print('addListener');
    _listeners.add(listener);
    // print('listeners: ${_listeners.length}');

    // Create worker if it doesn't exist
    _worker ??= ever(_rx, (_) {
      // Create a copy of the listeners list to avoid concurrent modification
      for (var listener in List.of(_listeners)) {
        listener();
      }
    });

    // Return a dispose function
    return () {
      removeListener(listener);
    };
  }

  void initState(T initialState) {
    if (_rx != null) {
      throw StateError('UniStateGetxMixin already initialized');
    }
    _rx = initialState.obs;
  }

  @override
  void onClose() {
    if (!_listeners.isEmpty) {
      print('Warning: UniStateGetxMixin disposed with active listeners');
    }
    _worker?.dispose();
    _worker = null;
    _listeners.clear();
    super.onClose();
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
    if (_listeners.isEmpty) {
      _worker?.dispose();
      _worker = null;
    }
  }
}
