part of 'member_bloc.dart';

@immutable
sealed class MemberEvent {}

final class LoadMember extends MemberEvent {}

final class AddMember extends MemberEvent {
  final Member member;

  AddMember({required this.member});
}

final class DeleteMember extends MemberEvent {
  final int id;

  DeleteMember({required this.id});
}

final class EditMember extends MemberEvent {
  final Member member;

  EditMember({required this.member});
}
