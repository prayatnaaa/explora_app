import 'package:dio/dio.dart';
import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/data/bloc/interest_bloc/interest_bloc.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
                bloc: BlocProvider.of<UserBloc>(context)..add(UserLoad()),
                builder: (context, state) {
                  if (state is UserInitial) {
                    BlocProvider.of<UserBloc>(context).add(UserLoad());
                  } else if (state is UserLoading) {
                    return const Center(child: LoadingScreen());
                  } else if (state is UserLoaded) {
                    final user = state.user;
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: themeColor),
                      child: Container(
                        margin: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                            child: "Welcome",
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.w600),
                                        MyText(
                                            child: user.name,
                                            fontSize: 16,
                                            color: black,
                                            fontWeight: FontWeight.bold)
                                      ]),
                                  IconButton(
                                      onPressed: () {
                                        context.go("/profile");
                                      },
                                      icon: Icon(
                                        Icons.info_outline,
                                        color: black,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is UserError) {
                    final errorMessage = state.message;
                    print(errorMessage);
                    return Center(
                      child: Text(
                        errorMessage.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            BlocBuilder<MemberBloc, MemberState>(
                bloc: BlocProvider.of<MemberBloc>(context)..add(LoadMember()),
                builder: (context, state) {
                  if (state is MemberInitial ||
                      state is MemberAdded ||
                      state is MemberDeleted ||
                      state is MemberEdited) {
                    BlocProvider.of<MemberBloc>(context).add(LoadMember());
                  } else if (state is MemberLoading) {
                    return Column(
                      children:
                          List.generate(5, (index) => const LoadingScreen()),
                    );
                  } else if (state is MemberLoaded) {
                    final members = state.members;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32, top: 24, bottom: 8),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      child: "Latest members",
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                  MyText(
                                      child: "Here are your latest members!",
                                      fontSize: 10,
                                      color: black,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: members.take(5).map((member) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 32),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: themeColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MyText(
                                    child: member.nama,
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else if (state is MemberError) {
                    final message = state.error;
                    return Center(
                      child: MyText(
                          child: message,
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.bold),
                    );
                  }
                  return Container();
                }),
            BlocBuilder(
                bloc: BlocProvider.of<InterestBloc>(context)..add(LoadBunga()),
                builder: (context, state) {
                  if (state is InterestInitial) {
                    BlocProvider.of<InterestBloc>(context).add(LoadBunga());
                  } else if (state is InterestLoading) {
                    return const Center(
                      child: LoadingScreen(),
                    );
                  } else if (state is BungaLoaded) {
                    final activeInterest = state.activeBunga.persen;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      child: "Interest info",
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                  MyText(
                                      child:
                                          "Here is your active interest information!",
                                      fontSize: 10,
                                      color: black,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 32),
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                    child: 'Active interest',
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                                MyText(
                                    child: '${activeInterest.toString()}%',
                                    fontSize: 36,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
