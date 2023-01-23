import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/views/screens/auth/login_screen.dart';
import 'package:snapshorts_app/views/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "SnapShorts App",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 65,
                    backgroundColor: backgroundColor,
                    child: Icon(
                      Icons.account_circle,
                      size: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        authController.imagePicker();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: borderColor,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: usernameController,
                labelText: "Username",
                isObscure: false,
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                labelText: "Email",
                isObscure: false,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                labelText: "Password",
                isObscure: true,
                prefixIcon: Icons.password,
              ),
              const SizedBox(height: 60),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // if (usernameController.text.isEmpty ||
                    //     emailController.text.isEmpty ||
                    //     passwordController.text.isEmpty ||
                    //     authController.profilePhoto == null) {
                    //   Get.snackbar(
                    //     "Please fill all fields",
                    //     "Enter all required fields for registration",
                    //   );
                    // } else {
                    authController.registerUser(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                      authController.profilePhoto,
                    );
                    // }
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?  ",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => const LoginScreen());
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                        color: buttonColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
