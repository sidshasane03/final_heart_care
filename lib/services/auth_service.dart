import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    signInOption: SignInOption.standard,
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // First check if already authenticated
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _auth.signOut();
        await _googleSignIn.signOut();
      }

      // Start fresh sign in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Google Sign In was cancelled by user');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      debugPrint('Got Google Auth tokens');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      debugPrint('Successfully signed in with Google: ${userCredential.user?.email}');
      return userCredential;
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
