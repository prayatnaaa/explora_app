part of 'interest_bloc.dart';

@immutable
sealed class InterestState {}

final class InterestInitial extends InterestState {}

final class InterestLoading extends InterestState {}

final class BungaLoaded extends InterestState {
  final List<Bunga> listBunga;
  final Bunga activeBunga;

  BungaLoaded(this.listBunga, this.activeBunga);
}

final class BungaError extends InterestState {
  final String errorDescription;

  BungaError(this.errorDescription);
}

final class BungaAdded extends InterestState {}
