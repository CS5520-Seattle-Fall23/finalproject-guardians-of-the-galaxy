import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HealthInfoScreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isFirstTimeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if key 'hasCompletedHealthProfile' exists
    return prefs.getBool('hasCompletedHealthProfile') ?? true;
  }

  void _navigateToNextScreen(BuildContext context, bool isFirstTime) {
    if (isFirstTime) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HealthInfoScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // User is signed in
            _isFirstTimeUser().then((isFirstTime) {
              _navigateToNextScreen(context, isFirstTime);
            });
            // Return a placeholder widget while determining if user is first-time
            return Container(color: Colors.white);
          } else {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: clientId),
              //fitbitProvider,
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/POSILIFE_Application_Logo.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FlutterFire, please sign in!')
                    : const Text('Welcome to Flutterfire, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }
        }
        return Center(child: CircularProgressIndicator());
        },
    );
  }
}
