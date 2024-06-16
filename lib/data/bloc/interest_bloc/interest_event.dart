part of 'interest_bloc.dart';

@immutable
sealed class InterestEvent {}

final class LoadInterest extends InterestEvent {}

final class AddInterest extends InterestEvent {
  final Bunga bunga;

  AddInterest({required this.bunga});
}
