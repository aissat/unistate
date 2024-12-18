// User State
class User {
  final String name;
  final int age;
  final String email;

  const User({
    this.name = '',
    this.age = 0,
    this.email = '',
  });

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ email.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.age == age &&
        other.email == email;
  }

  User copyWith({
    String? name,
    int? age,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, age: $age, email: $email)';
  }
}
