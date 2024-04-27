import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final _dio = Dio();
const _apiURL = 'https://mobileapis.manpits.xyz/api';
final _storage = GetStorage();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool errosStatus = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    void goLogin(email, password) async {
      try {
        final response = await _dio.post('$_apiURL/login',
            data: {'email': email, 'password': password});
        print(response.data);

        if (response.statusCode == 200) {
          await Navigator.pushNamed(context, '/user');
        }

        _storage.write('token', response.data['data']['token']);
      } on DioException catch (e) {
        print('${e.response} - ${e.response?.statusCode}');
        print(e.message);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Image(image: AssetImage("assets/map.png"))),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextField(
                onTap: () {
                  setState(() {
                    errosStatus = false;
                  });
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.montserrat(),
                decoration: const InputDecoration(
                    hintText: "Enter your email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xFF6C63FF)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, top: 16, right: 32, bottom: 8),
              child: TextField(
                onTap: () {
                  setState(() {
                    errosStatus = false;
                  });
                },
                obscureText: isPasswordHidden,
                controller: passwordController,
                style: GoogleFonts.montserrat(),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon:
                          Icon(isPasswordHidden ? Icons.lock : Icons.lock_open),
                    ),
                    hintText: "Password",
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xFF6C63FF)))),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 40),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: errosStatus,
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
                    backgroundColor: const Color(0xFF6C63FF)),
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
                  goLogin(emailController.text, passwordController.text);
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
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text(
                      "Register now",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C63FF)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
