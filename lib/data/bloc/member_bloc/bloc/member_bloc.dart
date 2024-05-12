import 'package:explora_app/data/remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/member.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final RemoteDataSource remoteDataSource;
  MemberBloc({required this.remoteDataSource}) : super(MemberInitial()) {
    on<LoadMember>((event, emit) async {
      emit(MemberLoading());
      try {
        final result = await remoteDataSource.getMembers();
        emit(MemberLoaded(result.anggotas));
      } catch (err) {
        emit(MemberError(err.toString()));
      }
    });
  }
}
