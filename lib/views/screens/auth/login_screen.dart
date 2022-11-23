import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortvideo/controllers/auth_controller.dart';
import 'package:shortvideo/utils/constant.dart';
import 'package:shortvideo/views/screens/auth/signup_screen.dart';
import 'package:shortvideo/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Short Video",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35,color: Colors.blue)),
              const Text("Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextInputField(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                  ),
                  TextInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isObscure: true,
                    icon: Icons.lock,
                  ),
                  ElevatedButton(onPressed: (){
                    authController.loginUser(email: _emailController.text, password: _passwordController.text);
                  }, child: const Text("Login")),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Text("Doesn't have an account?"),TextButton(onPressed: (){
                      Get.to(()=>SignupScreen());
                    }, child: const Text("Signup Now"))],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
