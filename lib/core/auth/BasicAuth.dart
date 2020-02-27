import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_n_dine/core/db/UsersCollection.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Auth.dart';


class BasicAuth implements Auth {
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
	final UsersCollection _usersCollection = UsersCollection();

  @override
  Future<FirebaseUser> signIn(String email, String password) async {
		AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
		);
		FirebaseUser user = result.user;

		return user;
  }

	@override
	Future<FirebaseUser> signUpWithEmail(String email, String password, String name) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: email,
				password: password
		);
		UserUpdateInfo info = UserUpdateInfo();
		info.displayName = name;

		FirebaseUser user = result.user;
		user.updateProfile(info);

		return user;
	}

	@override
	Future<FirebaseUser> signUpUser(User user, String password) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: user.email,
				password: password
		);

		UserUpdateInfo updateInfo = UserUpdateInfo();
		updateInfo.displayName = user.firstName + ' ' + user.lastName;
		updateInfo.photoUrl = user.photoUrl;

		FirebaseUser firebaseUser = result.user;
		firebaseUser.updateProfile(updateInfo);

		user.id = firebaseUser.uid;

		_usersCollection.addUser(user);

  	return firebaseUser;
	}

  @override
  Future<void> signOut() async {
		return _firebaseAuth.signOut();
  }

	@override
	Future<FirebaseUser> getCurrentFirebaseUser() async {
		return await _firebaseAuth.currentUser();
	}

	@override
	Future<User> getCurrentUser() async {
  	return (await _usersCollection.getUserByID((await getCurrentFirebaseUser()).uid)).first;
  }

  @override
  User getCurrentUserSync(){
  	User currentUser;
  	getCurrentUser().then((user) => currentUser = user);
  	return currentUser;
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




