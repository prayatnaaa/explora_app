import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberSnippet extends StatelessWidget {
  const MemberSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemberBloc(remoteDataSource: RemoteDataSource())..add(LoadMember()),
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, state) {
          if (state is MemberInitial || state is MemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MemberLoaded) {
            final members = state.members;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: MyText(
                      child: members[index].nama,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            );
          } else if (state is MemberError) {
            return const Center(child: Text('Failed to load members'));
          }
          return Container();
        },
      ),
    );
  }
}
