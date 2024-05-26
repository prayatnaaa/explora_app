part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserLoad extends UserEvent {}

class UserLogout extends UserEvent {}

class UserLogin extends UserEvent {
  final User user;

  UserLogin(this.user);
}

class UserRegister extends UserEvent {
  final User user;

  UserRegister({required this.user});
}
