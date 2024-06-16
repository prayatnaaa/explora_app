part of 'interest_bloc.dart';

@immutable
sealed class InterestState {}

final class InterestInitial extends InterestState {}

final class InterestLoading extends InterestState {}

final class InterestLoaded extends InterestState {
  final List<Bunga> bunga;
  final ActiveBunga currentBunga;
  InterestLoaded({required this.bunga, required this.currentBunga});
}

final class InterestAdded extends InterestState {}
