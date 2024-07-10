part of 'interest_bloc.dart';

@immutable
sealed class InterestEvent {}

final class LoadBunga extends InterestEvent {}

final class AddBunga extends InterestEvent {
  final Bunga bunga;

  AddBunga({required this.bunga});
}

final class InitBunga extends InterestEvent {}
