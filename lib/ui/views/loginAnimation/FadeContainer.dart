import 'package:dash_n_dine/ui/views/mainHomePage.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class FadeContainer extends StatefulWidget {
	final Color primaryColor;
	FadeContainer({this.primaryColor});

	@override
	_FadeContainerState createState() => _FadeContainerState();

}


class _FadeContainerState extends State<FadeContainer> with TickerProviderStateMixin {
	AnimationController _screenController;
	Animation<Color> fadeScreenAnimation;


	@override
	void initState() {
		_screenController = AnimationController(
				duration: Duration(
						milliseconds: 2000
				),
				vsync: this
		);

		fadeScreenAnimation = ColorTween(
				begin: widget.primaryColor,
				end: widget.primaryColor.withOpacity(0)
		).animate(CurvedAnimation(
				parent: _screenController,
				curve: Interval(
						0.0,
						1.0,
						curve: Curves.easeOutQuart
				)
		));
		super.initState();
	}


	@override
	Widget build(BuildContext context) {
		return Scaffold(
				body: AnimatedBuilder(
						animation: _screenController,
						builder: (context, child){
							return MainHomePage();
						}
				)
		);

	}

}