import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: BlocProvider.of<UserBloc>(context)..add(UserLoad()),
        builder: (context, userState) {
          if (userState is UserInitial) {
            BlocProvider.of<UserBloc>(context).add(UserLoad());
          } else if (userState is UserLoading) {
            return const Center(child: LoadingScreen());
          }
          if (userState is UserLoaded) {
            final user = userState.user;

            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                                child: "Name",
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal),
                            MyText(
                                child: user.name,
                                fontSize: 24,
                                color: white,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 20,
                            ),
                            MyText(
                                child: "Email",
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal),
                            MyText(
                                child: user.email,
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _logOutButton(onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => BlocProvider.value(
                                            value: context.read<UserBloc>(),
                                            child: Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    MyText(
                                                        child:
                                                            "Are you sure you want to log out?",
                                                        fontSize: 16,
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    _logOutButton(onTap: () {
                                                      BlocProvider.of<UserBloc>(
                                                              context)
                                                          .add(UserLogout());
                                                      context.go("/login");
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                }),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (userState is UserError) {
            return const Center(
              child: MyText(
                  child: "Something went bad!",
                  fontSize: 36,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            );
          }
          return Container();
        });
  }
}

Widget _logOutButton({required VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyText(
            child: "Log out",
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
