import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/models/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RemoteDataSource remoteDataSource;
  UserBloc({required this.remoteDataSource}) : super(UserInitial()) {
    on<UserLoad>(_loadUser);
    on<UserLogin>(_userLogin);
    on<UserLogout>(_userLogout);
    on<UserRegister>(_userRegister);
  }

  void _loadUser(UserLoad event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final result = await remoteDataSource.goUser();
      emit(UserLoaded(result));
    } on DioException catch (e) {
      print(e.message);
    }
  }

  FutureOr<void> _userLogin(UserLogin event, Emitter<UserState> emit) async {
    try {
      await remoteDataSource.goLogin(event.user);
      emit(UserLogged());
    } on DioException catch (e) {
      print(e.message);
    }
  }

  FutureOr<void> _userLogout(UserLogout event, Emitter<UserState> emit) async {
    try {
      await remoteDataSource.goLogout();
      emit(UserExit());
    } on DioException catch (e) {
      print(e.message);
    }
  }

  FutureOr<void> _userRegister(
      UserRegister event, Emitter<UserState> emit) async {
    try {
      await remoteDataSource.goRegister(event.user);
      emit(UserRegistered());
    } on DioException catch (e) {
      print(e.message);
    }
  }
}
