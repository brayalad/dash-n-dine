import 'package:dash_n_dine/core/model/Business.dart';
import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:flutter/material.dart';


class YelpResults extends StatefulWidget {

	@override
	_YelpResultsState createState() => _YelpResultsState();

}


class _YelpResultsState extends State<YelpResults>{
	Repository _repository = Repository.get();


  @override
  Widget build(BuildContext context) {
	  return Scaffold(
			  body: Center(
				  child: FutureBuilder<List<BusinessSearch>>(
					  future: _repository.getBusinesses(),
					  builder: (context, snapshot) {
						  if (snapshot.hasData) {
							  return Padding(
									  padding: const EdgeInsets.all(8.0),
									  child: ListView.builder(
											  itemCount: snapshot.data.length,
											  itemBuilder: (context, index) {
												  return Center(
													  child: Card(
														  child: Column(
															  mainAxisSize: MainAxisSize.min,
															  children: <Widget>[
																  Padding(padding: const EdgeInsets.all(8.0)),
																  ListTile(
																	  leading: Image.network(
																		  snapshot.data[index].imageUrl, width: 80,
																		  height: 80,),
																	  title: Text('${snapshot.data[index].name}'),
																	  subtitle: Text('${snapshot.data[index].categories[0].title}'),
																  ),
// ignore: deprecated_member_use
																  ButtonTheme.bar(
																	  // make buttons use the appropriate styles for cards
																	  child: ButtonBar(
																		  children: <Widget>[
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
																  ),
															  ],
														  ),
													  ),
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


class ResultView extends State<YelpResults>{
	Repository _repository = Repository.get();


	@override
	Widget build(BuildContext context) {
		return Scaffold(
				body: Center(
					child: FutureBuilder<List<BusinessSearch>>(
						future: _repository.getBusinesses(),
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								return Padding(
										padding: const EdgeInsets.all(8.0),
										child: ListView.builder(
												itemCount: snapshot.data.length,
												itemBuilder: (context, index) {
													return Center(
														child: Card(
															child: Column(
																mainAxisSize: MainAxisSize.min,
																children: <Widget>[
																	Padding(padding: const EdgeInsets.all(8.0)),
																	ListTile(
																		leading: Image.network(
																			snapshot.data[index].imageUrl, width: 80,
																			height: 80,),
																		title: Text('${snapshot.data[index].name}'),
																		subtitle: Text('${snapshot.data[index].categories[0].title}'),
																	),
// ignore: deprecated_member_use
																	ButtonTheme.bar(
																		// make buttons use the appropriate styles for cards
																		child: ButtonBar(
																			children: <Widget>[
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
																	),
																],
															),
														),
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
