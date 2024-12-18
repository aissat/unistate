import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';
import 'user.dart';

// Events
sealed class UserEvent {}

class UpdateNameEvent extends UserEvent {
  final String name;
  UpdateNameEvent(this.name);
}

class UpdateAgeEvent extends UserEvent {
  final int age;
  UpdateAgeEvent(this.age);
}

class UpdateEmailEvent extends UserEvent {
  final String email;
  UpdateEmailEvent(this.email);
}

class ResetEvent extends UserEvent {}

class UserBloc extends Bloc<UserEvent, User>
    with UnistateBlocMixin<UserEvent, User> {
  UserBloc() : super(const User()) {
    on<UpdateNameEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateAgeEvent>((event, emit) {
      emit(state.copyWith(age: event.age));
    });

    on<UpdateEmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<ResetEvent>((event, emit) {
      emit(const User());
    });
  }
}
