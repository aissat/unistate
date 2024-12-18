import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auto_dispose_mixin.dart';

/// Mixin for Bloc based classes
mixin UnistateBlocMixin<Event, State> on Bloc<Event, State>
    implements ValueListenable<State> {
  @override
  State get value => state;

  StreamSubscription? _subscription;

  @override
  void addListener(VoidCallback listener) {
    _subscription = stream.listen((_) => listener());
    // addDisposeCallback(() => _subscription?.cancel());
  }

  @override
  void removeListener(VoidCallback listener) {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() async {
    // dispose();
    await super.close();
  }
}
