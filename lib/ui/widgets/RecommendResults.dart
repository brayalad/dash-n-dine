import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/core/services/recommender.dart';
import 'package:dash_n_dine/ui/views/SearchPage.dart';
import 'package:flutter/material.dart';
import '../shared/text_styles.dart' as style;

import 'TitleAppBar.dart';


class RecommendResults extends StatefulWidget {

	@override
	_RecommendResultsState createState() => _RecommendResultsState();

}


class _RecommendResultsState extends State<RecommendResults>{
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
					  title: 'For You',
					  disableBackArrow: true,
					  text: Text(
							  'For You',
							  style: style.headerStyle2
					  )
			  ),
			  body: Center(
				  child: FutureBuilder<List<BusinessSearch>>(
					  future: _recommender.getRecommendations(),
					  builder: (context, snapshot) {
						  if (snapshot.hasData) {
							  return Padding(
									  padding: const EdgeInsets.all(8.0),
									  child: ListView.builder(
											  itemCount: snapshot.data.length,
											  itemBuilder: (context, index) {
												  return Center(
													  child: SearchResultCard(user: _user, business: snapshot.data[index],)
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


