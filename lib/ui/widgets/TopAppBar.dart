import 'package:flutter/material.dart';
import '../shared/text_styles.dart' as style;

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
	Size size;

	@override
	Widget build(BuildContext context) {
		size = MediaQuery.of(context).size;
		return PreferredSize(
			child: Container(
				padding: EdgeInsets.symmetric(
						horizontal: 12.0,
						vertical: 18.0
				),
				child: SafeArea(
					child: Row(
						mainAxisSize: MainAxisSize.max,
						children: <Widget>[
							GestureDetector(
									onTap: () {
									},
									child: Icon(
											Icons.shopping_cart,
											size: 32
									)
							),
							Expanded(
								child: Text(
									'Dine N Dash',
									style: style.appBarTextTheme,
									textAlign: TextAlign.center,
								),
							),
							GestureDetector(
								onTap: (){
								},
								child: Icon(
									Icons.notifications_none,
									size: 32,
								),
							),
						],
					),
				),
			),
		);
	}

	@override
	Size get preferredSize => Size.fromHeight(90);

}



