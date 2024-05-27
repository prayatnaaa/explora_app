part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final int memberId;
  final int transactionId;
  final int amount;

  AddTransaction(
      {required this.memberId,
      required this.transactionId,
      required this.amount});
}

class MemberTransaction extends TransactionEvent {
  final int id;

  MemberTransaction({required this.id});
}

class GetSavings extends TransactionEvent {
  final int id;

  GetSavings({required this.id});
}
