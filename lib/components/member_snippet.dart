import 'package:explora_app/components/null_data.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberSnippet extends StatelessWidget {
  const MemberSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) =>
            MemberBloc(remoteDataSource: RemoteDataSource())..add(LoadMember()),
        child: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            if (state is MemberInitial || state is MemberLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MemberLoaded) {
              final members = state.members;

              if (members.isEmpty) {
                return const NullData();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyText(
                            child: members[index].nama,
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is MemberError) {
              return const Center(child: Text('Failed to load members'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
