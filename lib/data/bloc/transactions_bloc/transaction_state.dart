part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionAdded extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class SavingLoaded extends TransactionState {
  final Saldo savings;

  SavingLoaded(this.savings);
}

final class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final int savings;

  TransactionLoaded(this.transactions, this.savings);
}

final class TransactionError extends TransactionState {
  final String? error;
  TransactionError(this.error);
}
