import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Auth.dart';


class BasicAuth implements Auth {
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
	final CollectionReference _usersCollection = Firestore.instance.collection('users');

  @override
  Future<String> signIn(String email, String password) async {
		AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
		);
		FirebaseUser user = result.user;

		CollectionReference col = Firestore.instance.collection('users');

		QuerySnapshot docs = await col.getDocuments();

		List<DocumentSnapshot> list = await docs.documents;
		print(list.length);
		for(var ds in list){
			await print(ds.data.toString());
		}

		return user.uid;
  }

	@override
	Future<String> signUpWithEmail(String email, String password, String name) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: email,
				password: password
		);
		UserUpdateInfo info = UserUpdateInfo();
		info.displayName = name;

		FirebaseUser user = result.user;
		user.updateProfile(info);

		return user.uid;
	}

	@override
	Future<String> signUpUser(User user, String password) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: user.email,
				password: password
		);

		UserUpdateInfo updateInfo = UserUpdateInfo();
		updateInfo.displayName = user.firstName + ' ' + user.lastName;
		updateInfo.photoUrl = user.photoUrl;

		FirebaseUser firebaseUser = result.user;
		firebaseUser.updateProfile(updateInfo);

		user.userId = firebaseUser.uid;

		await _usersCollection.add(user.toMap());

  	return firebaseUser.uid;
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




