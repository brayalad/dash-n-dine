import 'package:flutter/material.dart';
import '../shared/text_styles.dart' as style;

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
	final String title;
	TextAlign align;
	bool disableBackArrow;
	Text text;

	Size size;

	TitleAppBar({@required this.title, this.align, this.disableBackArrow, this.text});



	@override
	Widget build(BuildContext context) {
		List<Widget> widgets = List();

		if(disableBackArrow == null || false){
			widgets.add(
				GestureDetector(
					onTap: (){
						Navigator.pop(context) ;
					},
					child: Icon(
						Icons.arrow_back_ios,
						size: 18,
					),
				),
			);
		}



		widgets.add(
			Expanded(
				child: text ??
					Text(
						this.title,
						style: style.appBarTextTheme,
						textAlign: align ?? TextAlign.center,
				),
			),
		);

		size = MediaQuery.of(context).size;
		return PreferredSize(
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
				child: SafeArea(
					child: Row(
						mainAxisSize: MainAxisSize.max,
						children: widgets,
					),
				),
			),
		);
	}

	@override
	Size get preferredSize => Size.fromHeight(90);
}
