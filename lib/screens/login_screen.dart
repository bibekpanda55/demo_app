import 'package:demo_app/controller/auth_controller.dart';
import 'package:demo_app/routes.dart';
import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: Colors.green[700]!)),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldWidget(
                          controller: _emailController,
                          validator: (p0) => p0!.isEmpty
                              ? "Cannot be empty!"
                              : p0.length < 5 || p0.length > 30
                                  ? "Username should be between 5 and 30 characters"
                                  : null,
                          prefixIcon: const Icon(Icons.person_outlined),
                          onSaved: (p0) => p0,
                          hintText: "Username",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          validator: (p0) => p0!.isEmpty
                              ? "Cannot be empty!"
                              : p0.length < 6 || p0.length > 30
                                  ? "Password should be atleast 6 characters"
                                  : null,
                          //obscureText: _obscureText,
                          controller: _passwordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          onSaved: (p0) => p0,
                          // onObscureIconTap: _toggle,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                          onPressed: () async {
                            final fState = formKey.currentState;
                            if (fState!.validate()) {
                              await AuthController()
                                  .loginUsers(_emailController.text.trim(),
                                      _passwordController.text)
                                  .then((value) {
                                if (value) {
                                  Navigator.of(context)
                                      .pushNamed(RouteGenerator.homePage);
                                }
                              });
                            }
                          },
                          text: "LOGIN",
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(RouteGenerator.registerPage),
                                child: const Text(
                                  "If not registered,Register here!",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ))),
                      ],
                    ))),
          ],
        )));
  }

  // Future login() async {
  //   final fState = formKey.currentState;
  //   if (fState!.validate()) {
  //     try {
  //       await fbAuthService
  //           .signInWithEmailAndPassword(
  //               email: _emailController.text.trim(),
  //               password: _passwordController.text.trim())
  //           .then((value) async {
  //         if (value != null && value is! String) {
  //           sp.setString("email", _emailController.text.trim());
  //           sp.setString("pass", _passwordController.text.trim());
  //           await FbDbService.getAdminByUid(value?.uid).then((value) {
  //             print(value?.role);
  //             if (value?.role == Role.Admin) {
  //               Navigator.of(context)
  //                   .pushReplacementNamed(RouteGenerator.adminMenuPage);
  //             } else {
  //               Navigator.of(context)
  //                   .pushReplacementNamed(RouteGenerator.mainMenuPage);
  //             }
  //           });
  //         }
  //       });
  //     } catch (e) {
  //       showErrorToast(e.toString());
  //     }
  //   }
  // }

  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  // Future _resetPassword(String email, BuildContext context) async {
  //   // showDialog(
  //   //     context: context,
  //   //     builder: (ct) => Center(
  //   //           child: CircularProgressIndicator(
  //   //             color: Color(0xff63B9BA),
  //   //           ),
  //   //         ));
  //   try {
  //     await fbAuthService.resetPassword(email);

  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(const SnackBar(
  //           content:
  //               Text("Reset Password Email Sent.Please check your email.")));
  //   } catch (e) {
  //     print(e.toString());
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }
}
