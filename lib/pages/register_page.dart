import 'package:email_validator/email_validator.dart';
import 'package:explora_app/pages/home_page.dart';
import 'package:explora_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isVerifyPassHidden = true;
  bool errorStatus = false;
  String errorMesage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Image(image: AssetImage("assets/map.png"))),
                  Positioned(
                    top: 130,
                    left: 120,
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.montserrat(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 100,
                    child: Text(
                      "by creating a free account",
                      style: GoogleFonts.montserrat(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onTap: () {
                  setState(() {
                    errorStatus = false;
                  });
                },
                controller: emailController,
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onTap: () {
                  setState(() {
                    errorStatus = false;
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
                        icon: Icon(
                            isPasswordHidden ? Icons.lock : Icons.lock_open)),
                    hintText: "Password",
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xFF6C63FF)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onTap: () {
                  setState(() {
                    errorStatus = false;
                  });
                },
                obscureText: isVerifyPassHidden,
                controller: verifyPasswordController,
                style: GoogleFonts.montserrat(),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVerifyPassHidden = !isVerifyPassHidden;
                          });
                        },
                        icon: Icon(
                            isVerifyPassHidden ? Icons.lock : Icons.lock_open)),
                    hintText: "Verify password",
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
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: errorStatus,
                  child: Text(
                    errorMesage,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
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
                      "Next",
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
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      verifyPasswordController.text.isEmpty) {
                    setState(() {
                      errorStatus = true;
                    });
                    errorMesage = "Invalid. Please fill all the fields!";
                  } else if (!EmailValidator.validate(emailController.text)) {
                    setState(() {
                      errorStatus = true;
                    });
                    errorMesage =
                        "Please make sure the email you set is valid!";
                  } else if (passwordController.text.isEmpty &&
                      verifyPasswordController.text.isEmpty) {
                    setState(() {
                      errorStatus = true;
                      errorMesage =
                          "Please make sure that you fill the password!";
                    });
                  } else if (passwordController.text !=
                      verifyPasswordController.text) {
                    setState(() {
                      errorStatus = true;
                    });
                    errorMesage = "Please match your passwords!";
                  } else {
                    Navigator.pushReplacementNamed(context, '/menu');
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member? ",
                    style: GoogleFonts.montserrat(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      "Log in",
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
