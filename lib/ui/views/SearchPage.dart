import 'dart:ui';

import 'package:dash_n_dine/core/model/BusinessSearch.dart';
import 'package:dash_n_dine/core/services/repository.dart';
import 'package:flutter/material.dart';
import '../shared/text_styles.dart' as style;


class SearchPage extends StatefulWidget {
	@override
	_SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage>{
	final Repository _repository = Repository.get();

	TextEditingController _textController;

	void initState(){
		super.initState();
		_textController = TextEditingController();
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
																child: Card(
																	child: Column(
																		mainAxisSize: MainAxisSize.min,
																		children: <Widget>[
																			Padding(padding: const EdgeInsets.all(8.0)),
																			ListTile(
																				leading: Image.network(
																					snapshot.data[index].imageUrl, width: 80,
																					height: 80,
																				),
																				title: Text('${snapshot.data[index].name}'),
																				subtitle: Text('${snapshot.data[index].location.address1}\n${snapshot.data[index].categories[0].title}'),
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