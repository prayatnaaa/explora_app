import 'package:explora_app/services/api_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:explora_app/components/text.dart';
import 'package:explora_app/components/password_textfield.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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
          if (userState is UserRegistered) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: MyText(
                child: "Welcome, registration completed!",
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ));
            Navigator.pushReplacementNamed(context, "/login");
          }

          if (userState is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(mySnackBar('Something went wrong', Colors.red));
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
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Text(
                              "Welcome",
                              style: GoogleFonts.poppins(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Create account to access content",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      MyTextField(
                        onTap: () => setState(() => errorStatus = false),
                        hintText: "Enter your name",
                        controller: nameController,
                      ),
                      MyTextField(
                        onTap: () => setState(() => errorStatus = false),
                        hintText: "Enter your email",
                        controller: emailController,
                      ),
                      PasswordTextField(
                        hintText: "Create password",
                        onTap: () => setState(() => errorStatus = false),
                        controller: passwordController,
                      ),
                      PasswordTextField(
                        hintText: "Verify password",
                        onTap: () => setState(() => errorStatus = false),
                        controller: verifyPassController,
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
                      const SizedBox(height: 24),
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
                                "Create account",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFCFCFC),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            User user = User(
                              name: nameController.text,
                              email: emailController.text,
                            );
                            context.read<UserBloc>().add(
                                  UserRegister(
                                    user: user,
                                    password: verifyPassController.text,
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
                                "Log in",
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
                            Navigator.pushReplacementNamed(context, '/login');
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
