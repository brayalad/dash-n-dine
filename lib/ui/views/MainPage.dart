
import 'package:dash_n_dine/ui/views/HomePage.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';
import 'SearchPage.dart';

class MainPage extends StatefulWidget {
	@override
	_MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
	int _selectedIndex = 0;


	@override
	void initState(){
		super.initState();
	}

	Widget _getPage(page){
		if(page == 0){
			return HomePage();
		}
		if(page == 1){
			return SearchPage();
		}

		if(page == 3){
			return ProfilePage(
				profileImage: AssetImage('assets/profilepic.jpeg'),
				userName: 'Brayalad',
				fullName: 'Bryan Ayala',
				email: 'blayala@cpp.edu',
				address: '1234 Lane St.',
				dateOfBirth: '7/29/1998',
			);
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