import 'package:explora_app/components/text.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserBloc userBloc = UserBloc(remoteDataSource: RemoteDataSource());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => userBloc..add(UserLoad()), child: const Profile());
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      if (userState is UserInitial ||
          userState is UserLogged ||
          userState is UserExit) {
        userBloc.add(UserLoad());
      } else if (userState is UserLoading) {
        return const Center(child: Text("Ba"));
      } else if (userState is UserLoaded) {
        final user = userState.user;
        return Column(
          children: [Text(user.name), Text(user.email)],
        );
      } else if (userState is UserError) {
        return const Center(
            child: MyText(
                child: "Error",
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold));
      } else {}
      return Container();
    });
  }
}
