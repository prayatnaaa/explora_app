import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(remoteDataSource: RemoteDataSource())..add(UserLoad()),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        if (userState is UserLoaded) {
          final user = userState.user;

          return Column(
            children: [
              MyText(
                  child: user.name,
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.bold),
              MyText(
                  child: user.email,
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.bold),
            ],
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
      }),
    );
  }
}
