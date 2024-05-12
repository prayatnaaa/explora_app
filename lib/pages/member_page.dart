import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/remote_datasource.dart';
import 'package:explora_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemberBloc(remoteDataSource: RemoteDataSource())..add(LoadMember()),
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, memberState) {
          if (memberState is MemberLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (memberState is MemberLoaded) {
            final members = memberState.members;
            print(members);
            return SingleChildScrollView(
              // Wrap with SingleChildScrollView
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap:
                        true, // Ensure the ListView takes only the space it needs
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                        ),
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.person,
                                  color: themeColor,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //member name
                              Text(
                                members[index].nama,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeColor,
                                ),
                              ),
                              //member nomor_induk
                              MyText(
                                child: members[index].nomor_induk.toString(),
                                fontSize: 16,
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                              ),
                              //member telepon
                              MyText(
                                child: members[index].telepon,
                                fontSize: 12,
                                color: themeColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (memberState is MemberError) {
            return Center(
              child: Text(memberState.error),
            );
          }
          return const SizedBox(
            child: Text("Failed"),
          );
        },
      ),
    );
  }
}
