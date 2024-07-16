// lib/models/user_model.dart

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? password;
  final String? confirmPassword;

  const User({
    this.email,
    this.password,
    this.confirmPassword,
  });

  // Create a copyWith method for easy updates
  User copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword];
}
