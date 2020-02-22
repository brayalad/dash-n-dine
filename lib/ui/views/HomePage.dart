import 'package:flutter/material.dart';
import './signupPage.dart';
import './loginScreen.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
	final PageController _controller = PageController(
			initialPage: 1,
			viewportFraction: 1.0
	);


	@override
	void initState(){
		super.initState();
	}

	Widget HomePage(){
		final logo = Container(
			padding: EdgeInsets.only(
					top: MediaQuery.of(context).size.height * 0.3
			),
			child: Center(
				child: Image.asset(
					'assets/logo.png',
					color: Colors.white,
					height: MediaQuery.of(context).size.height * 0.1,
					width: MediaQuery.of(context).size.width * 0.2,
				),
			),
		);

		final title = Container(
			padding: EdgeInsets.only(top: 20.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'Dash',
						style: TextStyle(
							color: Colors.white,
							fontSize: 20.0,
						),
					),
					Text(
						'N',
						style: TextStyle(
								color: Colors.white,
								fontSize: 20.0,
								fontWeight: FontWeight.bold
						),
					),
					Text(
						'Dine',
						style: TextStyle(
							color: Colors.white,
							fontSize: 20.0,
						),
					),
				],
			),
		);

		final signup = Container(
			width: MediaQuery.of(context).size.width,
			margin: EdgeInsets.only(
					left: 30.0,
					right: 30.0,
					top: MediaQuery.of(context).size.height * 0.2),
			alignment: Alignment.center,
			child: Row(
				children: <Widget>[
					Expanded(
						child: OutlineButton(
							shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(30.0)),
							color: Colors.redAccent,
							highlightedBorderColor: Colors.redAccent,
							textColor: Colors.white,
							borderSide: BorderSide(
								color: Colors.white, //Color of the border
								style: BorderStyle.solid, //Style of the border
								width: 0.8, //width of the border
							),
							onPressed: () => gotoSignUp(),
							child: Container(
								padding: EdgeInsets.symmetric(
									vertical: 20.0,
									horizontal: 20.0,
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Expanded(
											child: Text(
												"SIGN UP",
												textAlign: TextAlign.center,
												style: TextStyle(
														color: Colors.white,
														fontWeight: FontWeight.bold),
											),
										),
									],
								),
							),
						),
					),
				],
			),
		);

		final login = Container(
			width: MediaQuery.of(context).size.width,
			margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
			alignment: Alignment.center,
			child: Row(
				children: <Widget>[
					Expanded(
						child: FlatButton(
							shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(30.0)),
							color: Colors.white,
							splashColor: Colors.redAccent,
							//highlightColor: Colors.blue,
							highlightColor: Colors.white,
							onPressed: () => gotoLogin(),
							child: Container(
								padding:  EdgeInsets.symmetric(
									vertical: 20.0,
									horizontal: 20.0,
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Expanded(
											child: Text(
												"LOGIN",
												textAlign: TextAlign.center,
												style: TextStyle(
														color: Theme.of(context).primaryColor,
														fontWeight: FontWeight.bold),
											),
										),
									],
								),
							),
						),
					),
				],
			),
		);

		return Container(
			child: Column(
				children: <Widget>[
					logo,
					title,
					signup,
					login
				],
			),
		);
	}

	gotoLogin() {
		_controller.animateToPage(
			0,
			duration: Duration(milliseconds: 800),
			curve: Curves.ease,
		);
	}

	gotoSignUp() {
		_controller.animateToPage(
			2,
			duration: Duration(milliseconds: 800),
			curve: Curves.ease,
		);
	}

  @override
  Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				height: MediaQuery.of(context).size.height,
				child: PageView(
					controller: _controller,
					physics: AlwaysScrollableScrollPhysics(),
					children: <Widget>[
						LoginScreen(),
						HomePage(),
						SignUpPage()
					],
					scrollDirection: Axis.horizontal,
				),
			),
		);

  }

}


