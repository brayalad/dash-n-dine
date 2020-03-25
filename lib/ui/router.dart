import 'package:dash_n_dine/ui/views/HomePage.dart';
import 'package:dash_n_dine/ui/views/MainPage.dart';
import 'package:dash_n_dine/ui/views/ProfilePage.dart';
import 'package:dash_n_dine/ui/views/SettingsPage.dart';
import 'package:dash_n_dine/ui/views/SplashPage.dart';
import 'package:dash_n_dine/ui/views/LoginScreen.dart';
import 'package:dash_n_dine/ui/views/SignupPage.dart';
import 'package:dash_n_dine/ui/widgets/ImageCapture.dart';
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
			case '/homePage':
				return MaterialPageRoute(builder: (_) => HomePage());
			case '/mainPage':
				return MaterialPageRoute(builder: (_) => MainPage());
			case '/splashPage':
				return MaterialPageRoute(builder: (_) => SplashPage());
			case '/imageCapture':
				return MaterialPageRoute(builder: (_) => ImageCapture());
			case '/settings':
				return MaterialPageRoute(builder: (_) => SettingsPage());
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