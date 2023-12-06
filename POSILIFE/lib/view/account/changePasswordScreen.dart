import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() async {
  String oldPassword = _oldPasswordController.text;
  String newPassword = _newPasswordController.text;
  String confirmPassword = _confirmPasswordController.text;

  if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
    // Show an alert dialog if fields are empty
    _showAlertDialog('Error', 'All fields are required.');
    return;
  }

  if (newPassword != confirmPassword) {
    // Show an alert dialog if new password and confirm password do not match
    _showAlertDialog('Error', 'New passwords do not match.');
    return;
  }

  // If you need to reauthenticate the user before changing the password,
  // you should do that here.

  try {
    // Change the password
    User? user = FirebaseAuth.instance.currentUser;
    await user?.updatePassword(newPassword);
    _showAlertDialog('Success', 'Password changed successfully.');
  } on FirebaseAuthException catch (e) {
    // Handle Firebase Auth exceptions such as weak password
    _showAlertDialog('Error', e.message ?? 'An unknown error occurred.');
  } catch (e) {
    // Handle other exceptions
    _showAlertDialog('Error', 'An unknown error occurred.');
  }
}

void _showAlertDialog(String title, String content) {
  showDialog(
    context: context, // You need to pass context here
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Your Password'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Old Password',
                hintText: 'Enter Your Old Password',
              ),
              obscureText: true, // Hide the text being edited (for passwords).
            ),
            SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter Your New Password',
              ),
              obscureText: true, // Hide the text being edited (for passwords).
            ),
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm Your New Password',
              ),
              obscureText: true, // Hide the text being edited (for passwords).
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100], // Button color
                foregroundColor: Colors.white, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
