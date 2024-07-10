import 'dart:async';

import 'package:dio/dio.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/member.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final RemoteDataSource remoteDataSource;
  MemberBloc({required this.remoteDataSource}) : super(MemberInitial()) {
    on<LoadMember>(_loadMember);
    on<LoadMemberById>(_loadMemberById);
    on<AddMember>(_addMember);
    on<DeleteMember>(_deleteMember);
    on<EditMember>(_editMember);
  }

  void _loadMember(LoadMember event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      final result = await remoteDataSource.getMembers();
      emit(MemberLoaded(result.anggotas));
    } on DioException catch (err) {
      emit(MemberError(err.toString()));
    }
  }

  void _addMember(AddMember event, Emitter<MemberState> emit) async {
    try {
      final result = await remoteDataSource.addMember(event.member);
      emit(MemberAdded());
    } on DioException catch (err) {
      emit(MemberError(err.message.toString()));
    }
  }

  void _editMember(EditMember event, Emitter<MemberState> emit) async {
    try {
      await remoteDataSource.editMember(event.member);
      emit(MemberEdited());
    } on DioException catch (err) {
      emit(MemberError(err.toString()));
    }
  }

  void _deleteMember(DeleteMember event, Emitter<MemberState> emit) async {
    try {
      await remoteDataSource.deleteMember(event.id);
      emit(MemberDeleted());
    } on DioException catch (err) {
      emit(MemberError(err.toString()));
    }
  }

  FutureOr<void> _loadMemberById(
      LoadMemberById event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      final result = await remoteDataSource.getMembersById(event.id);
      emit(MemberLoadedById(result));
    } on DioException catch (err) {
      emit(MemberError(err.toString()));
    }
  }
}
