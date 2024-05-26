part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

final class UserLogged extends UserState {}

final class UserRegistered extends UserState {}

final class UserExit extends UserState {}

final class UserError extends UserState {}
