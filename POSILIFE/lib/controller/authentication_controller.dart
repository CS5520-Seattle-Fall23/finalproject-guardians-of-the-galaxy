import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  User? get currentUser => _firebaseAuth.currentUser;

  String? getEmail() {
    return currentUser?.email;  // This will return the email of the signed-in user
  }

  // ... your other methods
  Future<void> sendPasswordResetEmail(String email) async {
  await _firebaseAuth.sendPasswordResetEmail(email: email);
  // The user will receive an email with instructions to reset their password
  }

  // change password procedures
  // This method is used to reauthenticate the user when they want to change their password
  Future<void> reauthenticateWithPassword(String email, String currentPassword) async {
    User? user = _firebaseAuth.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
    
    try {
      await user?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Handle error, e.g., wrong password
      print(e.message);
      throw e;
    }
  }

  // This method is used to change the user's password
  Future<void> changePassword(String newPassword) async {
    User? user = _firebaseAuth.currentUser;
    
    try {
      await user?.updatePassword(newPassword);
      // Success, password changed
    } on FirebaseAuthException catch (e) {
      // Handle error, possibly the password is too weak or the user's token has expired
      print(e.message);
      throw e;
    }
  }
}
