import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/interest_bloc/interest_bloc.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/pages/auth_screen/login_page.dart';
import 'package:explora_app/pages/main_page.dart';
import 'package:explora_app/pages/members/member_page.dart';
import 'package:explora_app/pages/members/member_profile.dart';
import 'package:explora_app/pages/scaffold_with_navbar.dart';
import 'package:explora_app/pages/transactions/add_transaction_page.dart';
import 'package:explora_app/pages/transactions/interest_page.dart';
import 'package:explora_app/pages/user/profile_page.dart';
import 'package:explora_app/pages/auth_screen/register_page.dart';
import 'package:explora_app/pages/user/user_page.dart';
import 'package:explora_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (BuildContext context) =>
                UserBloc(remoteDataSource: RemoteDataSource())
                  ..add(UserLoad())),
        BlocProvider<MemberBloc>(
            create: (BuildContext context) =>
                MemberBloc(remoteDataSource: RemoteDataSource())
                  ..add(LoadMember())),
        BlocProvider<TransactionBloc>(
            create: (BuildContext context) => TransactionBloc(
                transactionDatasource: TransactionDatasource())),
        BlocProvider<InterestBloc>(
            create: (BuildContext context) =>
                InterestBloc(remoteDataSource: TransactionDatasource())
                  ..add(LoadBunga()))
      ],
      child: MaterialApp.router(
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: white)),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(path: '/', builder: ((context, state) => const WelcomePage())),
    GoRoute(
        path: '/register', builder: ((context, state) => const RegisterPage())),
    GoRoute(path: '/login', builder: ((context, state) => const LoginPage())),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/user', builder: (context, state) => const UserPage()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/member',
                  builder: ((context, state) => const MemberPage())),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/interest',
                  builder: (context, state) => const InterestPage()),
            ],
          ),
        ]),
    GoRoute(
        path: '/profile',
        builder: ((context, state) => const UserProfilePage())),
    GoRoute(
        path: '/member/:id',
        builder: ((context, state) => MemberProfile(
              id: state.pathParameters["id"]!,
            ))),
    GoRoute(path: '/homepage', builder: ((context, state) => const MainPage())),
    GoRoute(
      path: '/add-transaction/:id',
      builder: (context, state) =>
          AddTransactionPage(transactionID: state.pathParameters["id"]!),
    )
  ]);
}
