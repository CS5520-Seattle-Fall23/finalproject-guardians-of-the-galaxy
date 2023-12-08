import '/view/login/signInScreen.dart';
import 'package:flutter/material.dart';
import '/view/login/signUpScreen.dart';

class PosiLifeHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset('assets/POSILIFE_Application_Logo.png'),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  // Implement sign-in functionality
                  // navigate to the sign-in screen
                  Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
                },
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Set the button's size
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  // Implement sign-up functionality
                  // navigate to the sign-up screen
                  Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Set the button's size
                ),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}