
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/ui/views/HomePage.dart';
import 'package:dash_n_dine/ui/views/LandingPage.dart';
import 'package:dash_n_dine/ui/widgets/TopAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'ProfilePage.dart';
import 'SearchPage.dart';

class MainPage extends StatefulWidget {
	@override
	_MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
	final LocationService _location = LocationService();

	var _auth = BasicAuth();
	int _selectedIndex = 0;
	User currentUser;
	Position _currentPosition;


	@override
	void initState(){
		super.initState();
		_location.getCurrentLocationAddress().then((value) {print(value);});
		_setCurrentUser();
		_setCurrentPosition();
	}

	void _setCurrentUser(){
		_auth.getCurrentUser().then((user) {
			setState(() {
			  currentUser = user;
			});
		});
	}

	void _setCurrentPosition(){
		_location.getCurrentLocation().then((pos) {
			setState(() {
			  _currentPosition = pos;
			});
		});
	}

	Widget _getPage(page){
		if(currentUser == null){
			return Container();
		}

		if(page == 0){
			return LandingPage();
		}
		if(page == 1){
			return SearchPage();
		}

		if(page == 3){
			return ProfilePage();
		}
	}

	void _onItemTapped(int index){
		setState(() {
			_selectedIndex = index;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: _getPage(_selectedIndex),
			appBar: TopAppBar(),
			bottomNavigationBar: BottomNavigationBar(
				selectedItemColor: Theme.of(context).hintColor,
				unselectedItemColor: Theme.of(context).primaryColor,
				currentIndex: _selectedIndex,
				items: const <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.home),
						title: Text('Home')
					),
					BottomNavigationBarItem(
							icon: Icon(Icons.search),
							title: Text('Search')
					),
					BottomNavigationBarItem(
							icon: Icon(Icons.fastfood),
							title: Text('For You')
					),
					BottomNavigationBarItem(
							icon: Icon(Icons.person),
							title: Text('Profile')
					)
				],
				onTap: _onItemTapped,
			),
		);
  }


}