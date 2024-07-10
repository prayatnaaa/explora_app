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
  final TransactionDatasource remoteDataSource;

  InterestBloc({required this.remoteDataSource}) : super(InterestInitial()) {
    on<LoadBunga>(_loadBunga);
    on<AddBunga>(_addBunga);
    on<InitBunga>(_initBunga);
  }

  void _loadBunga(LoadBunga event, Emitter<InterestState> emit) async {
    emit(InterestLoading());
    try {
      final result = await remoteDataSource.getBunga();
      if (result == null) {
        emit(BungaLoaded(const [], Bunga(id: 1, persen: 0, isActive: 0)));
      } else {
        emit(BungaLoaded(result.listBunga, result.activeBunga));
      }
    } on DioException catch (error) {
      emit(BungaError(error.message.toString()));
    }
  }

  void _addBunga(AddBunga event, Emitter<InterestState> emit) async {
    emit(InterestLoading());
    try {
      await remoteDataSource.addBunga(event.bunga);
      emit(BungaAdded());
    } on DioException catch (error) {
      emit(BungaError(
        error.response?.data,
      ));
    }
  }

  void _initBunga(InitBunga event, Emitter<InterestState> emit) async {
    emit(InterestInitial());
  }
}
