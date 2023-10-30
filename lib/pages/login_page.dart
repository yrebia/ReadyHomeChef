import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/my_textfield.dart'; // Importez MyTextField
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ready_home_chef/components/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder:(context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
      Navigator.pop(context);
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
                          Icon(
                            FontAwesomeIcons.utensils, // Utilisez une icône d'ustensile de cuisine
                            color: Colors.orange,
                            size: 30,
                          ),
                          Text(
                            ' Discover Home Recipes',
                            style: TextStyle(
                              fontFamily: 'georgia', // Remplacez par le nom de votre police
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'to Minimize Food Waste',
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
                      prefixIcon: FontAwesomeIcons.user, // Icon for Username
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: FontAwesomeIcons.lock, // Icon for Password
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password ?',
                            style: TextStyle(color: Color.fromARGB(255, 255, 231, 208),
                            fontFamily: 'georgia',),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    MyButton(
                      onTap: signUserIn,
                      text: 'Sign In',
                    ),
                    SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 231, 208),
                          fontFamily: 'georgia',
                          fontSize: 16, // Ajustez la taille de la police
                        ),
                      ),
                      SizedBox(width: 8), // Augmentez l'espacement horizontal
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Color.fromARGB(255, 186, 120, 43),
                            fontFamily: 'georgia',
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Ajustez la taille de la police
                          ),
                        ),
                      ),
                    ],
                  )

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