import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
	SplashPage({Key key}) : super(key: key);

	@override
	_SplashPageState createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
	Auth auth = BasicAuth();

	@override
	void initState() {
		super.initState();
			auth.getCurrentFirebaseUser()
					.then((user) {
				if (user == null) {
					Navigator.pushReplacementNamed(context, '/homePage');
				} else {
					Navigator.pushReplacementNamed(context, '/mainPage');
				}
			})
					.catchError((error) {
						print(error);
						Navigator.pushReplacementNamed(context, '/homePage');
			});


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


