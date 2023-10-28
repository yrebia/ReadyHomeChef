import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/my_button.dart';
import 'package:ready_home_chef/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder:(context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        errorMessage('Passwords don\'t match!');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-email') {
        errorMessage('Incorrect Email');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMessage('Incorrect Password');
      } else {
        errorMessage('A problem has occurred');
      }
    }
  }

  void errorMessage(String e) {
    showDialog(
      context: context,
      builder:(context) {
        return AlertDialog(
          title: Text('$e'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
        
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
        
                const SizedBox(height: 50),
        
                Text(
                  'Let\'s create an account !',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    ),
                  ),
        
                const SizedBox(height: 25),
        
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
        
                const SizedBox(height: 10),
        
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
        
                const SizedBox(height: 10),
        
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
        
                const SizedBox(height: 25),
                
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),
        
                const SizedBox(height: 50),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey [700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
        
            ],),
          ),
        ),
      )
    );
  }
}
