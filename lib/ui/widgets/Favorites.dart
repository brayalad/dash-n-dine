import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/db/UsersCollection.dart';
import 'package:dash_n_dine/core/model/Business.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/recommender.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:dash_n_dine/ui/widgets/TitleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/text_styles.dart' as style;


class Favorites extends StatefulWidget {

	@override
	_FavoritesState createState() => _FavoritesState();

}


class _FavoritesState extends State<Favorites>{
	Recommender _recommender = Recommender.get();

	User _user;

	void initState(){
		super.initState();
		_setCurrentUser();
	}

	void _setCurrentUser(){
		Auth.instance.getCurrentUser().then((usr) {
			setState(() {
				_user = usr;
			});
		});
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				appBar: TitleAppBar(
					title: 'Favorites',
					disableBackArrow: true,
					text: Text(
						'Favorites',
						style: style.headerStyle2
					)
				),
				body: Center(
					child: FutureBuilder<List<Business>>(
						future: _recommender.getFavorites(),
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								return Padding(
										padding: const EdgeInsets.all(8.0),
										child: ListView.builder(
												itemCount: snapshot.data.length,
												itemBuilder: (context, index) {
													return Center(
														child: FavoritesResultCard(user: _user, business: snapshot.data[index],),
													);
												}));
							} else if (snapshot.hasError) {
								return Padding(
										padding: const EdgeInsets.symmetric(horizontal: 15.0),
										child: Text("${snapshot.error}"));
							}

							// By default, show a loading spinner
							return CircularProgressIndicator();
						},
					),
				)
		);
	}

}

class FavoritesResultCard extends StatefulWidget {

	final User user;
	final Business business;

	const FavoritesResultCard({Key key, this.user, this.business}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _FavoritesResultCardState(user: user, business: business);
}


class _FavoritesResultCardState extends State<FavoritesResultCard>{

	final User user;
	final Business business;

	bool _liked;
	bool _moreInfoAvailable = true;

	_FavoritesResultCardState({this.user, this.business});


	@override
	void initState(){
		super.initState();
		_liked = user.favorites.contains(business.id);
		canLaunch(business.url).then((value) {
			setState(() {
				_moreInfoAvailable = value;
			});
		});
	}


	bool getLiked(){ return _liked; }

	void _like(){
		_liked = true;
		user.favorites.add(business.id);
		_updateUserInfo();
		setState(() {

		});
	}

	void _unlike(){
		_liked = false;
		user.favorites.remove(business.id);
		_updateUserInfo();
		setState(() {
		});
	}

	void _updateUserInfo(){
		UsersCollection.instance.updateUser(user);
	}

	_launchURL(String url) async {
		if(await canLaunch(url)){
			await launch(url);
		}
	}

	@override
	Widget build(BuildContext context) {
		if(user == null || business == null){
			return CircularProgressIndicator();
		}

		return Card(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Padding(padding: const EdgeInsets.all(8.0)),
					ListTile(
						leading: Image.network(
							//snapshot.data[index].imageUrl, width: 80,
							business.imageUrl,
							width: 80,
							height: 80,
						),
						title: Text('${business.name}'),
						subtitle: Text('${business.location.address1}\n${business.categories[0].title}\n${business.rating.toStringAsFixed(1)} stars'),
					),
					// make buttons use the appropriate styles for cards
					ButtonBar(
						children: <Widget>[
							IconButton(
								icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
								color: Theme.of(context).primaryColor,
								onPressed: (){
									if(_liked){
										_unlike();
									} else {
										_like();
									}
								},
							),
							Visibility(
								visible: _moreInfoAvailable,
								child: FlatButton(
									child: const Text('MORE INFO'),
									onPressed: () {
										_launchURL(business.url);
									},
								),
							)
						],
					),
				],
			),
		);
	}


}
