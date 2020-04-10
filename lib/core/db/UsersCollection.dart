import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/model/User.dart';

class UsersCollection {
	static final UsersCollection instance = UsersCollection();

	static final CollectionReference _usersCollection = Firestore.instance.collection('users');

	static final Auth _auth = Auth.instance;

	final Map<String, User> cache = HashMap();

	Future<void> addUser(User user){
		return _usersCollection.document(user.id).setData(user.toMap());
	}

	Future<User> getUserByID(String uid) async {
		if(cache.containsKey(uid)){
			User cached = cache[uid];
			if(cached != null){
				return cached;
			}
		}

		DocumentSnapshot result = await _usersCollection.document(uid).get();

		User user = User.fromMap(result.data);
		cache[uid] = user;

		return user;
	}

	Future<User> getUserByEmail(String email) async {
		return _getUser('email', email);
	}

	Future<User> getUserByUsername(String username) async {
		return _getUser('username', username);
	}

	Future<User> _getUser(String key, String value) async {
		List<DocumentSnapshot> docs = (await _usersCollection.where(key, isEqualTo: value).getDocuments()).documents;

		List<User> users = List();
		for(DocumentSnapshot doc in docs){
			users.add(User.fromMap(doc.data));
		}

		return users.first;
	}

	Future<void> updateUser(User updated) async {
		DocumentReference document = _usersCollection.document(updated.getID());
		await document.updateData(updated.toMap());
		User user = await _auth.updateUser();
		cache[user.id] = user;
	}

}