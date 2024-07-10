part of 'member_bloc.dart';

@immutable
sealed class MemberState {}

final class MemberInitial extends MemberState {}

final class MemberLoading extends MemberState {}

final class MemberLoaded extends MemberState {
  final List<Member> members;
  MemberLoaded(this.members);
}

final class MemberLoadedById extends MemberState {
  final MemberDetail memberDetail;
  MemberLoadedById(this.memberDetail);
}

final class MemberAdded extends MemberState {}

final class MemberEdited extends MemberState {}

final class MemberDeleted extends MemberState {}

final class MemberDetailed extends MemberState {}

final class MemberError extends MemberState {
  final String error;
  MemberError(this.error);
}
