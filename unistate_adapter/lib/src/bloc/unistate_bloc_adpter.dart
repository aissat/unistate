import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// An adapter for integrating a [Bloc] with [ValueNotifier].
///
/// The `BlocAdapter` listens to a [Bloc] and updates its value whenever
/// the bloc's state changes, allowing widgets to reactively listen
/// to state changes using [ValueListenable].
class BlocAdapter<S, E> extends ValueNotifier<E> {
  final Bloc<S, E> bloc;
  StreamSubscription<E>? _subscription;

  BlocAdapter(this.bloc, {E? initialValue})
      : super(initialValue ?? bloc.state) {
    _subscription = bloc.stream.listen((state) {
      value = state;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

extension BlocAdapterExtension<S, E> on Bloc<S, E> {
  ValueListenable<E> asValueListenable({E? initialValue}) {
    return BlocAdapter(this, initialValue: initialValue);
  }
}
