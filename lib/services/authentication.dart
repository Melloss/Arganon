import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<void> anonymousSignin() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInAnonymously();
    } catch (error) {
      print(error.toString());
    }
  }
}
