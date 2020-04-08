import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const String STORAGE_URL = 'gs://dash-n-dine.appspot.com';

class FileDownloader {
	static final FileDownloader instance = FileDownloader();

	final FirebaseStorage _storage = FirebaseStorage.instance;


	Future<String> getProfileImageURL(User user) async {
		//return await getImageURL(user.username + '_profile_pic');
		return await getImageURL(user.photoUrl);
	}

	Future<Image> getProfileImage(User user) async {
		//return await getImage(user.username + '_profile_pic');
		return await getImage(user.photoUrl);
	}

	Future<String> getImageURL(String image) async {
		StorageReference ref = await _storage.getReferenceFromUrl(STORAGE_URL);
		dynamic url = await ref.child('images').child(image).getDownloadURL();

		return url.toString();
	}

	Future<Image> getImage(String image) async {
		String url = await getImageURL(image);

		return Image.network(
			url,
			fit: BoxFit.scaleDown,
		);
	}

}


