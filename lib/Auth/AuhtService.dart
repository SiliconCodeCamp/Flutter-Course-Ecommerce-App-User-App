

import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_user_app/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User> register(String email,String password)async{
    final credential  = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    return credential.user!;
  }

  static Future<User> Login(String email,String password)async{
    final credential  = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return credential.user!;
  }

  static Future<void> Logout()=> _auth.signOut();

  static Future<UserCredential> signInWithGoogle()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final Cerdential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return _auth.signInWithCredential(Cerdential);

  }



}