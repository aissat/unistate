import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';
import 'user.dart';

class UserCubit extends Cubit<User> with UnistateCubitMixin<User> {
  UserCubit() : super( const User());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateAge(int age) {
    emit(state.copyWith(age: age));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void reset() {
    emit(const User());
  }
} 