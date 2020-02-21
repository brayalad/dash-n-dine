import 'package:flutter/material.dart';
import 'dart:async';
import './FadeContainer.dart';

class StaggeredAnimation extends StatelessWidget {

	StaggeredAnimation({
		Key key,
		this.buttonController,
		this.screenSize
	}) : buttonSqueezeAnimation = new Tween(
			begin: 320.0,
			end: 70.0
	).animate(
			CurvedAnimation(
					parent: buttonController,
					curve: Interval(
							0.0,
							0.150
					)
			)
	),
				buttonZoomOut = Tween(
						begin: 70.0,
						end: 1000.0
				).animate(
						CurvedAnimation(
								parent: buttonController,
								curve: Interval(
										0.550,
										0.999,
										curve: Curves.bounceOut
								)
						)
				),
				containerCircleAnimation = EdgeInsetsTween(
						begin: EdgeInsets.only(
								top: screenSize.height - 200
						),
						end: const EdgeInsets.only(
								top: 0.0
						)
				).animate(
						CurvedAnimation(
								parent: buttonController,
								curve: Interval(
										0.500,
										0.800,
										curve: Curves.ease
								)
						)
				),
				super(key : key);



	final Size screenSize;
	final AnimationController buttonController;
	final Animation<EdgeInsets> containerCircleAnimation;
	final Animation buttonSqueezeAnimation;
	final Animation buttonZoomOut;


	Future<Null> _playAnimation() async {
		try {
			await buttonController.forward();
		} on TickerCanceled {}
	}


	Widget _buildAnimation(BuildContext context, Widget child){
		return Padding(
			padding: (buttonZoomOut.value == 70)
					? EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.95 - 200)
					: containerCircleAnimation.value,
			child: InkWell(
				onTap: () {
					_playAnimation();
				},
				child: Hero(
						tag: 'fade',
						child: (buttonZoomOut.value <= 300)
								? Container(
								margin: const EdgeInsets.only(
										left: 30.0,
										right: 30.0,
										top: 20.0
								),
								width: (buttonZoomOut.value == 70)
										? buttonSqueezeAnimation.value
										: buttonZoomOut.value,
								height: (buttonZoomOut.value == 70) ? 60.0 : buttonZoomOut.value,
								alignment: FractionalOffset.center,
								decoration: BoxDecoration(
										color: Theme.of(context).primaryColor,
										borderRadius: (buttonZoomOut.value < 400)
												? new BorderRadius.all(const Radius.circular(30.0))
												:	new BorderRadius.all(const Radius.circular(0.0))
								),
								child: (buttonSqueezeAnimation.value > 75.0)
										? Text(
										'LOGIN',
										textAlign: TextAlign.center,
										style: TextStyle(
												color: Colors.white,
												fontWeight: FontWeight.bold
										)
								)
										: (buttonZoomOut.value < 300.0)
										? CircularProgressIndicator(
									value: null,
									strokeWidth: 1.0,
									valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
								)
										: null)
								: Container(
							width: buttonZoomOut.value,
							height: buttonZoomOut.value,
							decoration: BoxDecoration(
									shape: (buttonZoomOut.value < 500) ? BoxShape.circle : BoxShape.rectangle,
									color: Theme.of(context).primaryColor
							),
						)
				),
			),
		);
	}



	@override
	Widget build(BuildContext context) {
		buttonController.addListener(() {
			if(buttonController.isCompleted){
				Navigator.pushReplacement(
						context,
						MaterialPageRoute(
								builder: (context) => FadeContainer(
									primaryColor: Theme.of(context).primaryColor,
								)
						)
				);
			}
		});

		return AnimatedBuilder(
				builder: _buildAnimation,
				animation: buttonController
		);
	}

}