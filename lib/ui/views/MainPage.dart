
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/db/UsersCollection.dart';
import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/recommender.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:dash_n_dine/ui/views/HomePage.dart';
import 'package:dash_n_dine/ui/views/LandingPage.dart';
import 'package:dash_n_dine/ui/widgets/TopAppBar.dart';
import 'package:dash_n_dine/ui/widgets/YelpResults.dart';
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
	final Auth _auth = BasicAuth();

	int _selectedIndex = 0;
	User _currentUser;
	Position _currentPosition;


	@override
	void initState(){
		super.initState();
		_setCurrentUser();
		_setCurrentPosition();
	}

	void _setCurrentUser(){
		_auth.getCurrentUser().then((user) {
			setState(() {
			  _currentUser = user;
			});
		});
	}

	User getCurrentUser(){ return _currentUser; }

	void _setCurrentPosition(){
		_location.getCurrentLocation().then((pos) {
			setState(() {
			  _currentPosition = pos;
			});
		});
	}

	Position getCurrentPosition(){ return _currentPosition; }

	Widget _getPage(page){
		if(_currentUser != null){
			if(page == 0){
				return LandingPage();
			}

			if(page == 1){
				return SearchPage();
			}

			
			if(page == 2){
				/*
				CloudFunctions.instance
						.getHttpsCallable(functionName: 'recommend')
						.call(<String, dynamic> {
							'favorites': List.from(_currentUser.favorites),
							'latitude': _currentPosition.latitude,
							'longitude': _currentPosition.longitude
						}).then((value) => {
							print(value.data.toString())
				});
				 */
				return YelpResults();
			}
			

			if(page == 3){
				return ProfilePage();
			}
		}

		return Scaffold(
			body: Center(
					child: CircularProgressIndicator()
			),
		);
	}

	void _onItemTapped(int index){
		if(_selectedIndex == 2 && index != 2){
			_setUserTopCategory();
		}
		setState(() {
			_selectedIndex = index;
		});
	}

	void _setUserTopCategory(){
		Recommender.get().calculateCurrentUserTopCategories()
				.then((top) {
					_currentUser.topCategory = top.title;
					UsersCollection.instance.updateUser(_currentUser);
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