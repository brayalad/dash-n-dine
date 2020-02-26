import 'dart:async';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
	Future<String> signIn(String email, String password);

	Future<String> signUpWithEmail(String email, String password, String name);

	Future<String> signUpUser(User user, String password);

	Future<FirebaseUser> getCurrentUser();

	Future<void> sendEmailVerification();

	Future<void> signOut();

	Future<bool> isEmailVerified();
}