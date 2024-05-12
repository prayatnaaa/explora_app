part of 'member_bloc.dart';

@immutable
sealed class MemberState {}

final class MemberInitial extends MemberState {}

final class MemberLoading extends MemberState {}

final class MemberLoaded extends MemberState {
  final List<Member> members;
  MemberLoaded(this.members);
}

final class MemberError extends MemberState {
  final String error;
  MemberError(this.error);
}
