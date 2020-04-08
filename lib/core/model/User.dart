import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
	String id;
	String username;
	String email;
	String firstName;
	String lastName;
	String photoUrl;
	String phoneNumber;
	String address;
	String dateOfBirth;
	Set<String> favorites;
	String topCategory;

	User({
		@required this.id,
		@required this.username,
		@required this.email,
		@required this.firstName,
		@required this.lastName,
		@required this.photoUrl,
		this.phoneNumber,
		this.address,
		this.dateOfBirth,
		this.favorites,
		this.topCategory
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

	factory User.fromJson(Map<String, dynamic> json){
		return User(
				id: json['id'],
				username: json['username'],
				email: json['email'],
				firstName: json['firstName'],
				lastName: json['lastName'],
				photoUrl: json['photoUrl'],
				phoneNumber: json['phoneNumber'],
				address: json['address'],
				dateOfBirth: json['dateOfBirth'],
				favorites: json['favorites'].cast<String>(),
				topCategory: json['top_category']
		);
	}

	Map<String, dynamic> toJson(){
		final Map<String, dynamic> data = Map();
		data['id'] = this.id;
		data['username'] = this.username;
		data['email'] = this.email;
		data['firstName'] = this.firstName;
		data['lastName'] = this.lastName;
		data['photoUrl'] = this.photoUrl;
		data['phoneNumber'] = this.phoneNumber;
		data['address'] = this.address;
		data['dateOfBirth'] = this.dateOfBirth;
		data['favorites'] = this.favorites;
		data['top_category'] = this.topCategory;

		return data;
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
			dateOfBirth: map['dateOfBirth'],
			favorites: Set.from(map['favorites']),
			topCategory: map['top_category']
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
			'dateOfBirth': dateOfBirth,
			'favorites': favorites.map((v) => v.toString()).toList(),
			'top_category': topCategory
		};
	}


}