import 'package:flutter/foundation.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'user.dart';

class UserNotifier extends ValueNotifier<User>
    with UnistateNotifierMixin<User> {
  UserNotifier() : super(User());

  @override
  User get initialValue => const User();

  void reset() {
    value = const User();
  }

  void updateAge(int age) {
    value = value.copyWith(age: age);
  }

  void updateEmail(String email) {
    value = value.copyWith(email: email);
  }

  void updateName(String name) {
    value = value.copyWith(name: name);
  }
}
