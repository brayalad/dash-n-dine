import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';
import '../../core/food_list.dart';
import '../widgets/categories.dart';


class LandingPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<FoodList>(
			create: (context) => locator<FoodList>(),
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 12 ),
				child: ListView(
					children: <Widget>[
						FoodCategories()
					],
				),
			),
		);
	}
}
