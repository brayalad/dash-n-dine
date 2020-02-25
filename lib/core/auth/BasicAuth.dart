import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import './Auth.dart';


class BasicAuth implements Auth {
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signIn(String email, String password) async {
		AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
		);
		FirebaseUser user = result.user;

		return user.uid;
  }

	@override
	Future<String> signUp(String email, String password) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: email,
				password: password
		);
		FirebaseUser user = result.user;

		return user.uid;
	}

  @override
  Future<void> signOut() async {
		return _firebaseAuth.signOut();
  }

	@override
	Future<FirebaseUser> getCurrentUser() async {
		return await _firebaseAuth.currentUser();
	}

	@override
	Future<bool> isEmailVerified() async {
		FirebaseUser user = await _firebaseAuth.currentUser();
		return user.isEmailVerified;
	}

	@override
	Future<void> sendEmailVerification() async {
		FirebaseUser user = await _firebaseAuth.currentUser();
		user.sendEmailVerification();
	}

}




