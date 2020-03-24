import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
	var id;
	var username;
	var email;
	var firstName;
	var lastName;
	var photoUrl;
	var phoneNumber;
	var address;
	var dateOfBirth;

	User({
		@required this.id,
		@required this.username,
		@required this.email,
		@required this.firstName,
		@required this.lastName,
		@required this.photoUrl,
		this.phoneNumber,
		this.address,
		this.dateOfBirth
	});

	getID(){return id; }

	getUsername(){ return username; }

	setUsername(username){
		this.username = username;
	}

	getEmail(){ return email; }

	setEmail(username){
		this.username = username;
	}

	getPhoneNumber(){ return phoneNumber; }

	setPhoneNumber(phoneNumber){
		this.phoneNumber = phoneNumber;
	}

	getAddress(){ return address; }

	setAddress(address){
		this.address = address;
	}

	getDateOfBirth(){ return dateOfBirth; }

	setDateOfBirth(dateOfBirth){
		this.dateOfBirth = dateOfBirth;
	}

	static User fromMap(Map<String, dynamic> map){
		return User(
			id: map['id'],
			username: map['username'],
			email: map['email'],
			firstName: map['firstName'],
			lastName: map['lastName'],
			photoUrl: map['photoUrl'],
			phoneNumber: map['phoneNumber'],
			address: map['address'],
			dateOfBirth: map['dateOfBirth']
		);
	}

	Map<String, dynamic> toMap(){
		return {
			'id': id,
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