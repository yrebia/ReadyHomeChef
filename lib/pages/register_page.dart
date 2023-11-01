import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        // creer une entrée dans la DB
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
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background Image
              Image(
                image: AssetImage('lib/img/sel.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 900,
              ),
              // Gradient Container
              Container(
                width: double.infinity,
                height: 900,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 90, 51, 21).withOpacity(0.0),
                      Color.fromARGB(255, 78, 51, 36).withOpacity(0.8),
                      Color.fromARGB(255, 137, 48, 4).withOpacity(0.15),
                      Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/img/logo.png',
                      width: 350,
                      height: 350,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register now and join us',
                            style: TextStyle(
                              fontFamily: 'georgia',
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'to Dicover delicious Home Recipes',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 231, 208),
                        fontSize: 16,
                        fontFamily: 'Trebuchet MS',
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 25),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: FontAwesomeIcons.user,
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: FontAwesomeIcons.lock,
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      prefixIcon: FontAwesomeIcons.userLock,
                    ),
                    SizedBox(height: 25),
                    MyButton(
                      onTap: signUserUp,
                      text: 'Sign Up',
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 231, 208),
                            fontSize: 16,
                            fontFamily: "georgia",
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: Color.fromARGB(255, 186, 120, 43),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "georgia",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
