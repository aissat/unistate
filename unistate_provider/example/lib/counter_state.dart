import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_provider/unistate.dart';

class CounterCubit extends Cubit<CounterState>
    implements UniState<CounterState> {
  CounterCubit() : super(CounterState.initial()) {
    debugPrint('CounterCubit initialized with initial state');
  }

  @override
  void dispose() {
    dispose();
  }

  @override
  void performAction(String actionType, [dynamic payload]) {
    switch (actionType) {
      case 'increment':
        final newState = state.copyWith(count: state.count + 1);
        print('Emitting new state: $newState');
        emit(newState);
        break;
      case 'decrement':
        final newState = state.copyWith(count: state.count - 1);
        print('Emitting new state: $newState');
        emit(newState);
        break;
    }
  }

  @override
  void resetState() {
    emit(CounterState.initial());
  }

  @override
  void updateState(CounterState newState) {
    emit(newState);
  }
}

class CounterState {
  final int count;

  CounterState({required this.count});

  factory CounterState.initial() => CounterState(count: 0);

  CounterState copyWith({int? count}) {
    return CounterState(count: count ?? this.count);
  }
}
