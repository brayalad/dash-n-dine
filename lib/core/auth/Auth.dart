import 'dart:async';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
	Future<FirebaseUser> signIn(String email, String password);

	Future<FirebaseUser> signUpWithEmail(String email, String password, String name);

	Future<FirebaseUser> signUpUser(User user, String password);

	Future<FirebaseUser> getCurrentFirebaseUser();
	
	Future<User> getCurrentUser();

	User getCurrentUserSync();

	Future<void> sendEmailVerification();

	Future<void> signOut();

	Future<bool> isEmailVerified();
}