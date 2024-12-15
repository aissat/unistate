import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_provider/unistate.dart';

class ResetUserEvent extends UserEvent {}

class UpdateAgeEvent extends UserEvent {
  final int age;
  UpdateAgeEvent(this.age);
}

class UpdateEmailEvent extends UserEvent {
  final String email;
  UpdateEmailEvent(this.email);
}

class UpdateNameEvent extends UserEvent {
  final String name;
  UpdateNameEvent(this.name);
}

class UpdateUserEvent extends UserEvent {
  final UserState updatedState;
  UpdateUserEvent(this.updatedState);
}

// Bloc Implementation for User State
class UserBloc extends Bloc<UserEvent, UserState>
    implements UniState<UserState> {
  UserBloc() : super(UserState()) {
    on<UpdateUserEvent>((event, emit) => emit(event.updatedState));
    on<ResetUserEvent>((event, emit) => emit(UserState()));
    on<UpdateNameEvent>(
        (event, emit) => emit(state.copyWith(name: event.name)));
    on<UpdateAgeEvent>((event, emit) => emit(state.copyWith(age: event.age)));
    on<UpdateEmailEvent>(
        (event, emit) => emit(state.copyWith(email: event.email)));
  }

  @override
  void dispose() {
    // super.dispose();
    dispose();
  }

  @override
  void performAction(String actionType, [dynamic payload]) {
    switch (actionType) {
      case 'updateUser':
        add(UpdateUserEvent(payload));
        break;
      case 'updateName':
        add(UpdateNameEvent(payload));
        break;
      case 'updateAge':
        add(UpdateAgeEvent(payload));
        break;
      case 'updateEmail':
        add(UpdateEmailEvent(payload));
        break;
      case 'reset':
        add(ResetUserEvent());
        break;
    }
  }

  @override
  void resetState() {
    add(ResetUserEvent());
  }

  @override
  void updateState(UserState newState) {
    add(UpdateUserEvent(newState));
  }
}

// Cubit Implementation for User State
class UserCubit extends Cubit<UserState> implements UniState<UserState> {
  UserCubit() : super(UserState()) {
    debugPrint('UserCubit initialized with initial state');
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void performAction(String actionType, [dynamic payload]) {
    debugPrint(
        'UserCubit: Performing action $actionType with payload $payload');

    UserState newState;
    switch (actionType) {
      case 'updateUser':
        debugPrint('Resetting state');
        newState = payload;
        break;
      case 'updateName':
        debugPrint('Updating name to $payload');
        newState = state.copyWith(name: payload);
        break;
      case 'updateAge':
        debugPrint('Updating age to $payload');
        newState = state.copyWith(age: payload);
        break;
      case 'updateEmail':
        debugPrint('Updating email to $payload');
        newState = state.copyWith(email: payload);
        break;
      default:
        debugPrint('Unknown action type: $actionType');
        return;
    }

    // Only emit if the state has actually changed
    if (newState != state) {
      debugPrint('Emitting new state: $newState');
      emit(newState);
    }
  }

  @override
  void resetState() {
    debugPrint('UserCubit: Resetting state');
    emit(UserState());
  }

  // Additional specific methods
  void updateProfile(String name, int age, String email) {
    debugPrint('Updating full profile: name=$name, age=$age, email=$email');
    final newState = UserState(name: name, age: age, email: email);

    // Only emit if the state has actually changed
    if (newState != state) {
      emit(newState);
    }
  }

  @override
  void updateState(UserState newState) {
    debugPrint('UserCubit: Updating state to $newState');
    emit(newState);
  }
}

// User State Events
abstract class UserEvent {}

// Provider-like Implementation
class UserProvider extends ChangeNotifier
    implements UniState<UserState>, ValueListenable<UserState> {
  UserState _state = UserState();

  @override
  UserState get state => _state;

  @override
  UserState get value => _state;

  @override
  void performAction(String actionType, [dynamic payload]) {
    switch (actionType) {
      case 'updateUser':
        _state = payload;
        break;
      case 'updateName':
        _state = _state.copyWith(name: payload);
        break;
      case 'updateAge':
        _state = _state.copyWith(age: payload);
        break;
      case 'updateEmail':
        _state = _state.copyWith(email: payload);
        break;
      case 'reset':
        _state = UserState();
        break;
    }
    notifyListeners();
  }

  @override
  void resetState() {
    _state = UserState();
    notifyListeners();
  }

  @override
  void updateState(UserState newState) {
    _state = newState;
    notifyListeners();
  }
}

// User State
class UserState {
  final String name;
  final int age;
  final String email;

  UserState({
    this.name = '',
    this.age = 0,
    this.email = '',
  });

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ email.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.name == name &&
        other.age == age &&
        other.email == email;
  }

  UserState copyWith({
    String? name,
    int? age,
    String? email,
  }) {
    return UserState(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserState(name: $name, age: $age, email: $email)';
  }
}
