import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/models/user.dart';
import 'package:explora_app/services/api_user.dart';
import 'package:explora_app/components/password_textfield.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UserController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool errorStatus = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(remoteDataSource: RemoteDataSource()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, userState) {
          if (userState is UserLogged) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: MyText(
                    child: "Login successfully!",
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.bold)));
            Navigator.pushReplacementNamed(context, "/main");
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Stack(
                          children: [
                            const Align(
                                alignment: Alignment.centerRight,
                                child:
                                    Image(image: AssetImage("assets/map.png"))),
                            Positioned(
                              top: 130,
                              left: 120,
                              child: Text(
                                "Welcome back",
                                style: GoogleFonts.montserrat(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              top: 170,
                              left: 100,
                              child: Text(
                                "Sign in to access your account",
                                style: GoogleFonts.montserrat(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      //   child: TextField(
                      //     onTap: () {
                      //       setState(() {
                      //         errorStatus = false;
                      //       });
                      //     },
                      //     controller: emailController,
                      //     keyboardType: TextInputType.emailAddress,
                      //     style: GoogleFonts.montserrat(),
                      //     decoration: const InputDecoration(
                      //         hintText: "Enter your email",
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(20))),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(20)),
                      //             borderSide: BorderSide(color: Color(0xFF6C63FF)))),
                      //   ),
                      // ),
                      MyTextField(
                          onTap: () {
                            setState(() {
                              errorStatus = false;
                            });
                          },
                          hintText: "Enter your email",
                          controller: emailController),
                      PasswordTextField(
                          hintText: "Enter your Password",
                          onTap: () {
                            setState(() {
                              errorStatus = false;
                            });
                          },
                          controller: passwordController),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 32, top: 16, right: 32, bottom: 8),
                      //   child: TextField(
                      //     onTap: () {
                      //       setState(() {
                      //         errorStatus = false;
                      //       });
                      //     },
                      //     obscureText: isPasswordHidden,
                      //     controller: passwordController,
                      //     style: GoogleFonts.montserrat(),
                      //     decoration: InputDecoration(
                      //         suffixIcon: IconButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               isPasswordHidden = !isPasswordHidden;
                      //             });
                      //           },
                      //           icon:
                      //               Icon(isPasswordHidden ? Icons.lock : Icons.lock_open),
                      //         ),
                      //         hintText: "Password",
                      //         enabledBorder: const OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(20))),
                      //         focusedBorder: const OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(20)),
                      //             borderSide: BorderSide(color: Color(0xFF6C63FF)))),
                      //   ),
                      // ),
                      Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Visibility(
                                visible: errorStatus,
                                child: Text(
                                  errorMessage,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ))),
                      Container(
                        margin: const EdgeInsets.only(top: 80),
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: themeColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFCFCFC)),
                              ),
                              const Icon(
                                Icons.navigate_next,
                                color: Color(0xFFFCFCFC),
                              )
                            ],
                          ),
                          onPressed: () {
                            context.read<UserBloc>().add(UserLogin(
                                emailController.text, passwordController.text));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New Member? ",
                              style: GoogleFonts.montserrat(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                "Register now",
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      )
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
