
import 'package:dash_n_dine/ui/views/HomePage.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';

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