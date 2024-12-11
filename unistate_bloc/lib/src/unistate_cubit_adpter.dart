import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// An adapter for integrating a [Cubit] with [ValueNotifier].
///
/// The `CubitAdapter` listens to a [Cubit] and updates its value whenever
/// the cubit's state changes, allowing widgets to reactively listen
/// to state changes using [ValueListenable].
class CubitAdapter<T> extends ValueNotifier<T> {
  final Cubit<T> cubit;
  StreamSubscription<T>? _subscription;

  CubitAdapter(this.cubit, {T? initialValue})
      : super(initialValue ?? cubit.state) {
    _subscription = cubit.stream.listen((state) {
      value = state;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

extension CubitAdapterExtension<T> on Cubit<T> {
  ValueListenable<T> asValueListenable({T? initialValue}) {
    return CubitAdapter(this, initialValue: initialValue);
  }
}
