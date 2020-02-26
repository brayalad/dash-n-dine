import 'package:flutter/foundation.dart';

class User {
	String userId;
	String username;
	String email;
	String firstName;
	String lastName;
	String photoUrl;
	String phoneNumber;
	String address;
	String dateOfBirth;

	User({
		@required this.userId,
		@required this.username,
		@required this.email,
		@required this.firstName,
		@required this.lastName,
		@required this.photoUrl,
		this.phoneNumber,
		this.address,
		this.dateOfBirth
	});


	Map<String, dynamic> toMap(){
		return {
			'userId': userId,
			'username': username,
			'email': email,
			'firstName': firstName,
			'lastName': lastName,
			'photoUrl': photoUrl,
			'phoneNumber': phoneNumber,
			'address': address,
			'dateOfBirth': dateOfBirth
		};
	}


}