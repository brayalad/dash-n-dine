import 'dart:ui';

import 'package:flutter/material.dart';
import '../shared/text_styles.dart' as style;


class SearchPage extends StatefulWidget {
	@override
	_SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
		return Scaffold(
			body: SingleChildScrollView(
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
												child: TextFormField(
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
						)
					],
				),
			),
		);
  }



}