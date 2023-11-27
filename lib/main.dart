import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/firebase_options.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Set this to false
      home: HomePage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignupPage.routeName: (context) => SignupPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),

        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
            child: Text('Login') ,
            style: ElevatedButton.styleFrom(primary: Colors.lightBlue),

          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, SignupPage.routeName);
            },
            child: Text('Sign Up'),
            style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
          ),
        ],
      ),
      body: Center(
        child: Text('Your home page content goes here'),
      ),
    );
  }
}
