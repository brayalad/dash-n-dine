import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './HomePage.dart';


class SplashPage extends StatefulWidget {
	SplashPage({Key key}) : super(key: key);

	@override
	_SplashPageState createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {

	@override
	void initState() async {
		FirebaseUser user = await FirebaseAuth.instance.currentUser();
		if(user == null){
			Navigator.pushReplacementNamed(context, '/homePage');
		} else {
			Navigator.pushReplacementNamed(context, '/mainPage');
		}
		super.initState();
	}


  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  body: Center(
			  child: Container(
				  child: Text('Loading...'),
			  ),
		  ),
	  );
  }


}


