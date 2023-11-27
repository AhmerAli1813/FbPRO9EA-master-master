import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';


  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formkey =GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
@override
  void dispose() {
    // TODO: implement dispose
  nameController.dispose();
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  super.dispose();
  }
  String? signUpError;
  bool showSuccess = false;
  void signInUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // User signed up successfully
      User? user = userCredential.user;
      String? uid = user?.uid;
      String? email = user?.email;

      // Set the success message and update the state
      setState(() {
        showSuccess = true;
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          showSuccess = false;
        });

        // Clear form data
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        // Navigate to login page
        Navigator.pushNamed(context, LoginPage.routeName);
      });
    } catch (error) {
      // Handle errors during sign up
      print('Error during sign up: $error');
      // Set the error message and update the state
      setState(() {
        signUpError = 'Error during sign up: $error';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 600,
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up Page',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),

                  ),
                  if (showSuccess)
                    MyTextGreenField(
                      title: 'Successfully Signed Up!',
                      message:
                      'UID: ${FirebaseAuth.instance.currentUser?.uid}\nEmail: ${FirebaseAuth.instance.currentUser?.email}',
                    ),
                  if (signUpError != null)
                    MyTextGreenField(
                      title: 'Sign Up Failed',
                      message: signUpError!,
                    ),
                  MyTextField(text: 'Full Name', icon: const Icon(Icons.person), controller: nameController, yes: false,),
                  MyTextField(text: 'Email', icon: const Icon(Icons.email), controller: emailController, yes: false,),
                  MyTextField(text: 'Password', icon: const Icon(Icons.lock), controller: passwordController, yes: true ,),
                  MyTextField(text: 'Confirm Password', icon: const Icon(Icons.lock), controller: confirmPasswordController, yes: true,),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text('Forgot Password'),
                  ),
                  Container(
                    height: 50,
                    width: 1000,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign up'),
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          signInUser();
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already Have an account ?'),
                      TextButton(
                        child: const Text(
                          'Sign-In',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.yes,
  });

  final String text;
  final Icon icon;
  final bool yes;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        // validator: (value){
        //   if(value!.isEmpty){
        //     return "Please Enter a value";
        //   }
        // },
        obscureText: yes,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: text,
            prefixIcon: icon),
      ),
    );
  }
}

class MyTextGreenField extends StatelessWidget {
  final String title;
  final String message;

  MyTextGreenField({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.green,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          message,
          style: TextStyle(
            color: Colors.green,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}