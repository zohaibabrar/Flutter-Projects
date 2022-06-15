// ignore_for_file: must_call_super, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:stock_app/screen/credentials/login_screen.dart';

import 'package:stock_app/screen/credentials/pwd_reset_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    // loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(31, 122, 140, 1),
          ));
        });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    // pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            // back color container
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.44,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(31, 122, 140, 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.12,
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Text(
                  'Effortless Stock \nManagement',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),

            // sign in column container
            Center(
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Color.fromARGB(255, 81, 81, 83),
                                  offset: Offset(0, 10),
                                ),
                              ]),
                          child: Column(
                            children: [
                              // Sign in
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'Sign in',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // email => textfield
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Email',
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // password => textfield
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Forgot Password
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PasswordResetScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 36, 149, 172),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // sign in button
                              GestureDetector(
                                onTap: signIn,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 36, 149, 172),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign in',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 13),

                              // Already have account
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Already have an account
                                  Text(
                                    'Not a Staff?   ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                  ),
                                  // login => button
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 36, 149, 172),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
