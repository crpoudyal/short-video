import 'package:flutter/material.dart';
import 'package:shortvideo/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
               child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const SizedBox(height: 50,),
                    const Text("Short Video",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            color: Colors.blue)),
                    const Text("Signup",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage("https://i1.sndcdn.com/avatars-000252187355-42nbzf-t500x500.jpg"),
                          backgroundColor: Colors.blue,
                        ),
                        Positioned(
                            bottom: -10,
                            left: 60,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add_a_photo)))
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      children: [
                        TextInputField(
                          controller: _usernameController,
                          labelText: 'Username',
                          icon: Icons.person,
                        ),
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
                        TextInputField(
                          controller: _conformController,
                          labelText: 'Conform Password',
                          isObscure: true,
                          icon: Icons.lock,
                        ),
                        ElevatedButton(onPressed: () {}, child: const Text("Signup")),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                                onPressed: () {}, child: const Text("Login Now"))
                          ],
                        )
                      ],
                    )
                  ],
                ),
          ),
           ),
        ),
    );
  }
}
