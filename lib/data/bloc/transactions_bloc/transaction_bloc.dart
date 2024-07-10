import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionDatasource transactionDatasource;
  TransactionBloc({required this.transactionDatasource})
      : super(TransactionInitial()) {
    on<MemberTransaction>(_loadTransaction);
    on<AddTransaction>(_addTransaction);
    on<GetSavings>(_getSavings);
  }

  FutureOr<void> _loadTransaction(
      MemberTransaction event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final result = await transactionDatasource.getTransaction(event.id);
      final savings = await transactionDatasource.getSavings(event.id);
      emit(TransactionLoaded(result.transactions, savings.saldo));
    } on DioException catch (e) {
      emit(TransactionError(e.message));
    }
  }

  FutureOr<void> _addTransaction(
      AddTransaction event, Emitter<TransactionState> emit) async {
    try {
      await transactionDatasource.addTransaction(
          event.memberId, event.transactionId, event.amount);
      emit(TransactionAdded());
    } on DioException catch (e) {
      emit(TransactionError(e.message));
    }
  }

  FutureOr<void> _getSavings(
      GetSavings event, Emitter<TransactionState> emit) async {
    try {
      final result = await transactionDatasource.getSavings(event.id);
      emit(SavingLoaded(result));
    } on DioException catch (e) {
      emit(TransactionError(e.message));
    }
  }
}
