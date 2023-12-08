import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignInScreen.dart'; 
import 'PosiLifeHomeScreen.dart'; 

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _cycleLengthController = TextEditingController();
  final _periodLengthController = TextEditingController();
  final _medicalConditionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user in FirebaseAuth
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Add user details to Firestore 'Users' collection
        await _firestore.collection('Users').doc(userCredential.user!.uid).set({
          'UserId': userCredential.user!.uid,
          'UserName': _userNameController.text,
          'Age': _ageController.text,
          'Height': _heightController.text,
          'Weight': _weightController.text,
          'CycleLength': _cycleLengthController.text,
          'MedicalCondition': _medicalConditionController.text,
          'PeriodLength': _periodLengthController.text,
          'Email': _emailController.text,
        });

        // Navigate to SignInScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Handle errors, such as email already in use, weak password, etc.
        final snackBar = SnackBar(content: Text('Error: ${e.message}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _cycleLengthController.dispose();
    _periodLengthController.dispose();
    _medicalConditionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POSI LIFE'),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PosiLifeHomeScreen()),
        ),
        ),
      ),
      body: Scrollbar(
        thickness: 6.0, // Set the thickness of the scrollbar
        radius: Radius.circular(10), // Set the radius of the scrollbar edges
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/POSILIFE_headerLogo.png'),
                TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'User Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your username' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Please confirm your password';
                  if (value != _passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter your age' : null,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height'),
                validator: (value) => value!.isEmpty ? 'Please enter your height' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                validator: (value) => value!.isEmpty ? 'Please enter your weight' : null,
              ),
              TextFormField(
                controller: _cycleLengthController,
                decoration: InputDecoration(labelText: 'Cycle Length'),
                validator: (value) => value!.isEmpty ? 'Please enter your cycle length' : null,
              ),
              TextFormField(
                controller: _periodLengthController,
                decoration: InputDecoration(labelText: 'Period Length'),
                validator: (value) => value!.isEmpty ? 'Please enter your period length' : null,
              ),
              TextFormField(
                controller: _medicalConditionController,
                decoration: InputDecoration(labelText: 'Medical Conditions (if any)'),
              ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[200],
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to SignInScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text('Already a user? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
