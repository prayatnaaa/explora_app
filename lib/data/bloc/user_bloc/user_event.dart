part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserLoad extends UserEvent {}

class UserLogout extends UserEvent {}

class UserLogin extends UserEvent {
  final String email;
  final String password;

  UserLogin(this.email, this.password);
}

class UserRegister extends UserEvent {
  final User user;
  final String password;

  UserRegister({required this.user, required this.password});
}
