import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_n_dine/core/model/User.dart';

class UsersCollection {
	final CollectionReference _usersCollection = Firestore.instance.collection('users');

	Future<void> addUser(User user){
		return _usersCollection.document(user.id).setData(user.toMap());
	}

	Future<List<User>> getUserByID(String uid) async {
		return _getUser('id', uid);
	}

	Future<List<User>> getUserByEmail(String email) async {
		return _getUser('email', email);
	}

	Future<List<User>> getUserByUsername(String username) async {
		return _getUser('username', username);
	}

	Future<List<User>> _getUser(String key, String value) async {
		List<DocumentSnapshot> docs = (await _usersCollection.where(key, isEqualTo: value).getDocuments()).documents;

		List<User> users = List();
		for(DocumentSnapshot doc in docs){
			users.add(User.fromMap(doc.data));
		}

		return users;
	}

}