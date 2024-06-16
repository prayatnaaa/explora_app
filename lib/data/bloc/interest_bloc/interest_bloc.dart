import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/models/interest.dart';
import 'package:get/utils.dart';
import 'package:meta/meta.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  final TransactionDatasource transactionDatasource;
  InterestBloc({required this.transactionDatasource})
      : super(InterestInitial()) {
    on<LoadInterest>(_loadInterest);
    on<AddInterest>(_addInterest);
  }

  FutureOr<void> _loadInterest(
      LoadInterest event, Emitter<InterestState> emit) async {
    emit(InterestLoading());
    try {
      final result = await transactionDatasource.getBunga();
      final currentBunga = await transactionDatasource.getActiveBunga();
      emit(InterestLoaded(bunga: result.bungas, currentBunga: currentBunga));
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  FutureOr<void> _addInterest(
      AddInterest event, Emitter<InterestState> emit) async {
    try {
      final result = await transactionDatasource.addInterest(event.bunga);

      emit(InterestAdded());
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
