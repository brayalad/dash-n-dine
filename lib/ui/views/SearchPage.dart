import 'dart:ui';

import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/db/UsersCollection.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:more/collection.dart';
import '../shared/text_styles.dart' as style;


class SearchPage extends StatefulWidget {
	@override
	_SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage>{
	final Repository _repository = Repository.get();

	final TextEditingController _textController = TextEditingController();

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
			body: Container(
				child: Column(
					children: <Widget>[
						Stack(
							children: <Widget>[
								Column(
									children: <Widget>[
										Container(
											padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 10.0),
											child: Material(
												elevation: 10.0,
												borderRadius: BorderRadius.circular(25.0),
												child: TextField(
													controller: _textController,
													onChanged: (val) {
														setState(() {

														});
													},
													decoration: InputDecoration(
														border: InputBorder.none,
														prefixIcon: Icon(Icons.search),
														contentPadding: EdgeInsets.only(
															left: 15.0,
															top: 15.0
														),
														hintText: 'Search',
														hintStyle: TextStyle(
															color: Theme.of(context).hintColor
														)
													),
												),
											),
										)
									],
								)
							],
						),
						Expanded(
							child: FutureBuilder<List<BusinessSearch>>(
								future: _repository.searchBusinesses(_textController.text),
								builder: (context, snapshot) {
									if (snapshot.hasData) {
										return Padding(
												padding: const EdgeInsets.all(8.0),
												child: ListView.builder(
														shrinkWrap: true,
														itemCount: snapshot.data.length,
														itemBuilder: (context, index) {
															return Center(
																child: SearchResultCard(user: _user, business: snapshot.data[index])
															);
														})
										);
									} else if (snapshot.hasError) {
										return Padding(
												padding: const EdgeInsets.symmetric(horizontal: 15.0),
												child: Text("${snapshot.error}"));
									}

									// By default, show a loading spinner
									return Container();
								},
							),
						)
					],
				),
			),
		);
  }

}


class SearchResultCard extends StatefulWidget {
	
	final User user;
	final BusinessSearch business;

  const SearchResultCard({Key key, this.user, this.business}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultCardState(user: user, business: business);
}


class _SearchResultCardState extends State<SearchResultCard>{

	final User user;
	final BusinessSearch business;

	bool _liked;

  _SearchResultCardState({this.user, this.business});


	@override
	void initState(){
		super.initState();
		_liked = user.favorites.contains(business.id);
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
				    subtitle: Text('${business.location.address1}\n${business.categories[0].title}'),
			    ),
			    // make buttons use the appropriate styles for cards
			    ButtonBar(
				    children: <Widget>[
					    IconButton(
						    icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
						    color: Colors.red,
						    onPressed: (){
									if(_liked){
										_unlike();
									} else {
										_like();
									}
						    },
					    ),
					    FlatButton(
						    child: const Text('WEBSITE'),
						    // ignore: deprecated_member_use
						    onPressed: () {
							    //_launchURL(snapshot.data[index].url);
						    },
					    ),
					    FlatButton(
						    child: const Text('NAVIGATE'),
						    onPressed: () {
							    //todo: launch using google/apple maps
						    },
					    ),
				    ],
			    ),
		    ],
	    ),
    );
  }
	
	
}

