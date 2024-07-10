import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/components/password_textfield.dart';
import 'package:explora_app/components/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool errorStatus = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    SnackBar mySnackBar(String text, Color? backgroundColor) {
      return SnackBar(
        padding: const EdgeInsets.all(8),
        showCloseIcon: true,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 70,
            left: 10,
            right: 10),
        closeIconColor: white,
        backgroundColor: backgroundColor,
        content: MyText(
          child: text,
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return BlocProvider(
      create: (context) => UserBloc(remoteDataSource: RemoteDataSource()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, userState) {
          if (userState is UserLogged) {
            context.go("/user");
          }
          if (userState is UserError) {
            final message = userState.message;
            ScaffoldMessenger.of(context)
                .showSnackBar(mySnackBar(message.toString(), Colors.red));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return Scaffold(
              backgroundColor: white,
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome back",
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sign in to access your account",
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      MyTextField(
                        onTap: () => setState(() => errorStatus = false),
                        hintText: "Enter your email",
                        controller: emailController,
                      ),
                      PasswordTextField(
                        hintText: "Enter your password",
                        onTap: () => setState(() => errorStatus = false),
                        controller: passwordController,
                      ),
                      if (errorStatus)
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          alignment: Alignment.topLeft,
                          child: Text(
                            errorMessage,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: themeColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log in",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFCFCFC),
                                ),
                              ),
                              const Icon(
                                Icons.navigate_next,
                                color: Color(0xFFFCFCFC),
                              ),
                            ],
                          ),
                          onPressed: () {
                            context.read<UserBloc>().add(
                                  UserLogin(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: themeColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create new account",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeColor,
                                ),
                              ),
                              const Icon(
                                Icons.navigate_next,
                                color: Color(0xFFFCFCFC),
                              ),
                            ],
                          ),
                          onPressed: () {
                            context.go("/register");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
