import 'package:flutter/material.dart';
import 'package:ready_home_chef/components/my_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon; // New property for prefix icon

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon, // Initialize prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
          prefixIcon: Icon(
            prefixIcon, // Use the provided prefixIcon
            color: Colors.grey[500], // Customize the color of the icon
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    // Add your login logic here.
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
          fontFamily: 'verdana', // Remplacez par le nom de votre police
          color: Colors.orange,
          fontSize: 25,
          fontWeight: FontWeight.w200,
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
    fontWeight: FontWeight.w300
  ),
),
                    SizedBox(height: 25),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
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
                            style: TextStyle(color: Color.fromARGB(255, 255, 231, 208)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    MyButton(
                      onTap: signUserIn,
                    ),
                    SizedBox(height: 50),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      'Not a member?',
      style: TextStyle(
        color: Color.fromARGB(255, 255, 231, 208),
        fontSize: 16, // Ajustez la taille de la police
      ),
    ),
    SizedBox(width: 8), // Augmentez l'espacement horizontal
    Text(
      'Register now',
      style: TextStyle(
        color: Color.fromARGB(255, 186, 120, 43),
        fontWeight: FontWeight.bold,
        fontSize: 16, // Ajustez la taille de la police
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
