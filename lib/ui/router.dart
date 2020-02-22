import 'package:dash_n_dine/ui/views/ProfilePage.dart';
import 'package:dash_n_dine/ui/views/loginScreen.dart';
import 'package:dash_n_dine/ui/views/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


const String initialRoute = 'login';


class Router {

	static Route<dynamic> generateRoute(RouteSettings settings){
		switch(settings.name){
			case '/login':
				return MaterialPageRoute(builder: (_) => LoginScreen());
			case '/signup':
				return MaterialPageRoute(builder: (_) => SignUpPage());
			case '/profilePage':
				return MaterialPageRoute(builder: (_) => ProfilePage());
			default:
				return MaterialPageRoute(
					builder: (_) => Scaffold(
						body: Center(
							child: Text('No route defined for ${settings.name}'),
						),
					)
				);
		}
	}

}