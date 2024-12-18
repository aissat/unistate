import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

sealed class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> with UnistateBlocMixin<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }

  @override
  void addDisposeCallback(VoidCallback callback) {
    // TODO: implement addDisposeCallback
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
} 