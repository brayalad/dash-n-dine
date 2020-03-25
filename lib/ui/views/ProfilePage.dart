import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/ui/views/SettingsPage.dart';
import 'package:dash_n_dine/ui/widgets/FileDownloader.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:dash_n_dine/ui/shared/theme.dart';
import '../shared/text_styles.dart' as style;

class ProfilePage extends StatefulWidget {
	@override
	_ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
	final _auth = BasicAuth();
	final _loader = FileDownloader();

	User user;
	ImageProvider image;


	@override
	void initState() {
		super.initState();
		_setUserInfo();
	}

	_setUserInfo(){
		_auth.getCurrentUser().then((res) {
			setState(() {
				user = res;
				_loader.getProfileImageURL(this.user).then((url) {
					setState(() {
						image = NetworkImage(url);
					});
				});
			});
		});
	}

	@override
	Widget build(BuildContext context) {
		if(user == null || image == null){
			return new Container();
		}

		final theme = Provider.of<ThemeDelegate>(context);
		return Scaffold(
			body: SingleChildScrollView(
				physics: BouncingScrollPhysics(),
				child: Column(
					mainAxisSize: MainAxisSize.max,
					children: <Widget>[
						Container(
							child: Stack(
								children: <Widget>[
									//background
									Container(
										child: Column(
											children: <Widget>[
												Container(
													height: MediaQuery.of(context).size.height * 0.45,
													color: Colors.transparent,
													child: ClipPath(
														clipper: BackClipper(),
														child: Container(
															color: Theme.of(context).primaryColor,
														),
													),
												),
											],
										),
									),
									//forground
									Container(
										child: Column(
											children: <Widget>[
												Container(
													child: Center(
														child: Container(
															height: 90.0,
															width: 90.0,
															padding: EdgeInsets.all(10.0),
															decoration: BoxDecoration(
																	color: Theme.of(context).scaffoldBackgroundColor,
																	borderRadius: BorderRadius.circular(100.0)
															),
															child: InkWell(
																child: CircleAvatar(
																	backgroundColor: Colors.white,
																	backgroundImage: image,
																),
																onTap: () {
																	Navigator.pushNamed(context, '/imageCapture').then((value) { _setUserInfo(); });
																},
															),
														),
													),
												),
												SizedBox(
													height: 5.0,
												),
												Container(
													padding: EdgeInsets.symmetric(horizontal: 15.0),
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceAround,
														children: <Widget>[
															InkWell(
																onTap: () {
																	theme.toggleTheme();
																},
																child: Container(
																	width: 90.0,
																	height: 45.0,
																	child: Center(
																		child: Icon(
																			Icons.lightbulb_outline,
																			size: 35,
																		),
																	),
																),
															),
															Container(
																child: Column(
																	children: <Widget>[
																		Text(
																			user.username ?? '',
																			style: style.headerStyle3,
																		),
																		SizedBox(
																			height: 10.0,
																		),
																	],
																),
															),
															InkWell(
																onTap: () {
																	Navigator.pushNamed(context, '/settings').then((val) { _setUserInfo(); });
																},
																child: Container(
																	width: 90.0,
																	height: 45.0,
																	child: Center(
																		child: Icon(
																			Icons.settings,
																			size: 35,
																		),
																	),
																),
															),
														],
													),
												),
												SizedBox(
													height: 10.0,
												),
												Container(
													padding: EdgeInsets.symmetric(horizontal: 20.0),
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceEvenly,
														children: <Widget>[
															Container(
																width: MediaQuery.of(context).size.width * 0.45,
																child: Column(
																	mainAxisAlignment: MainAxisAlignment.center,
																	children: <Widget>[
																		Text(
																				'Email',
																				style: style.headerStyle3.copyWith(
																						fontWeight: FontWeight.w500
																				),
																				textAlign: TextAlign.center
																		),
																		SizedBox(
																			height: 5,
																		),
																		Text(
																				user.email ?? '',
																				style: TextStyle(
																					fontSize: 15.0,
																				),
																				textAlign: TextAlign.center
																		),
																	],
																),
															),
															Container(
																color: Colors.white.withOpacity(0.5),
																width: 1.0,
																height: 40.0,
															),
															Container(
																width: MediaQuery.of(context).size.width * 0.45,
																child: Column(
																	children: <Widget>[
																		Text(
																				'Phone',
																				style: style.headerStyle3.copyWith(
																						fontWeight: FontWeight.w500
																				),
																				textAlign: TextAlign.center
																		),
																		SizedBox(
																			height: 5,
																		),
																		Text(
																			user.phoneNumber ?? '',
																			style: TextStyle(
																				fontSize: 15.0,
																			),
																			textAlign: TextAlign.center,
																		),
																	],
																),
															),
														],
													),
												),
												SizedBox(
													height: 15.0,
												),
												GridView.count(
													crossAxisCount: 2,
													primary: false,
													crossAxisSpacing: 2.0,
													mainAxisSpacing: 4.0,
													shrinkWrap: true,
													childAspectRatio: 2.0,
													children: <Widget>[
														_buildCard('Reward points', '155', Icons.card_giftcard, 1),
														_buildCard('Favorites', '5', Icons.favorite, 2),
													],
												),
												SizedBox(
													height: 50.0,
												),
												ListView(
													physics: NeverScrollableScrollPhysics(),
													shrinkWrap: true,
													children: <Widget>[
														InkWell(
															onTap: () {},
															child: Container(
																padding: EdgeInsets.symmetric(horizontal: 25),
																height: MediaQuery.of(context).size.height * 0.08,
																width: MediaQuery.of(context).size.width,
																child: Row(
																	mainAxisAlignment:
																	MainAxisAlignment.spaceBetween,
																	children: <Widget>[
																		Column(
																			crossAxisAlignment:
																			CrossAxisAlignment.start,
																			children: <Widget>[
																				Text(
																					'Full Name',
																					style: style.headerStyle3,
																				),
																				Text(
																					'${user.firstName} ${user.lastName}',
																					style: style.subHintTitle,
																				)
																			],
																		),
																		IconButton(
																			icon: Icon(Icons.edit),
																			onPressed: (){
																				Navigator.pushNamed(context, '/settings').then((val) { _setUserInfo(); });
																			},
																		)
																	],
																),
															),
														),
														InkWell(
															onTap: () {},
															child: Container(
																padding: EdgeInsets.symmetric(horizontal: 25),
																height: MediaQuery.of(context).size.height * 0.08,
																width: MediaQuery.of(context).size.width,
																child: Row(
																	mainAxisAlignment:
																	MainAxisAlignment.spaceBetween,
																	children: <Widget>[
																		Column(
																			crossAxisAlignment:
																			CrossAxisAlignment.start,
																			children: <Widget>[
																				Text(
																					'Address',
																					style: style.headerStyle3,
																				),
																				Text(
																					user.address ?? '',
																					style: style.subHintTitle,
																				)
																			],
																		),
																		IconButton(
																			icon: Icon(Icons.edit),
																			onPressed: (){
																				Navigator.pushNamed(context, '/settings').then((val) { _setUserInfo(); });
																			},
																		)
																	],
																),
															),
														),
														InkWell(
															onTap: () {},
															child: Container(
																padding: EdgeInsets.symmetric(horizontal: 25),
																height: MediaQuery.of(context).size.height * 0.08,
																width: MediaQuery.of(context).size.width,
																child: Row(
																	mainAxisAlignment:
																	MainAxisAlignment.spaceBetween,
																	children: <Widget>[
																		Column(
																			crossAxisAlignment:
																			CrossAxisAlignment.start,
																			children: <Widget>[
																				Text(
																					'Date of Birth',
																					style: style.headerStyle3,
																				),
																				Text(
																					user.dateOfBirth ?? '',
																					style: style.subHintTitle,
																				)
																			],
																		),
																		IconButton(
																			icon: Icon(Icons.edit),
																			onPressed: (){
																				Navigator.pushNamed(context, '/settings').then((val) { _setUserInfo(); });
																			},
																		)
																	],
																),
															),
														)
													],
												)
											],
										),
									)
								],
							),
						),
					],
				),
			),
		);
	}


	Widget _buildCard(String title, String value, icon, int cardIndex) {
		return Container(
				decoration: BoxDecoration(
						color: Theme.of(context).cardColor,
						borderRadius: BorderRadius.circular(15.0),
						boxShadow: [
							BoxShadow(
									spreadRadius: 1.0, blurRadius: 5.0, color: Colors.black38
							)
						]
				),
				child: Column(
					children: <Widget>[
						SizedBox(
								height: 15.0
						),
						Container(
							padding: EdgeInsets.symmetric(horizontal: 10.0),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: <Widget>[
									Text(
										title,
										style: TextStyle(
											fontSize: MediaQuery.of(context).size.width * 0.045,
										),
									),
									Icon(icon)
								],
							),
						),
						Expanded(
								child: Container(
										width: 175.0,
										decoration: BoxDecoration(
											borderRadius: BorderRadius.only(
													bottomLeft: Radius.circular(10.0),
													bottomRight: Radius.circular(10.0)
											),
										),
										child: Center(
											child: Text(
												value,
												style: TextStyle(
														fontSize: 25.0,
														color: Theme.of(context).primaryColor
												),
											),
										)
								)
						)
					],
				),
				margin: cardIndex.isEven
						? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
						: EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
	}

}


class _InfoInkWell extends StatelessWidget {
	final title;
	final value;

	_InfoInkWell({this.title, this.value});


  @override
  Widget build(BuildContext context) {
		return InkWell(
			onTap: () {},
			child: Container(
				padding: EdgeInsets.symmetric(
					horizontal: 0.25
				),
				height: MediaQuery.of(context).size.height * 0.08,
				width: MediaQuery.of(context).size.width,
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text(
									title,
									style: style.headerStyle3,
								),
								Text(
									value != null ? value : '',
									style: style.subHintTitle,
								)
							],
						),
						Icon(Icons.edit)
					],
				),
			),
		);
  }

}


class _InfoContainer extends StatelessWidget {
	final title;
	final value;


	_InfoContainer({this.title, this.value});


  @override
  Widget build(BuildContext context) {
		return Container(
			width: MediaQuery.of(context).size.width * 0.45,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						title,
						style: style.headerStyle3.copyWith(
								fontWeight: FontWeight.w500
						),
						textAlign: TextAlign.center,
					),
					SizedBox(
						height: 5,
					),
					Text(
						value == null ? '' : value,
						style: TextStyle(
								fontSize: 15.0
						),
						textAlign: TextAlign.center,
					)
				],
			),
		);

  }

}


class BackClipper extends CustomClipper<Path> {

	@override
	Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - (size.height / 5));

    var firstControlPoint = Offset(size.width / 2, size.height + 25);
    var firstEndPoint = Offset(size.width, size.height - size.height / 5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);

    var secondControlPoint = Offset(size.width / 2, size.height / 5 + 25);
    var secondEndPoint = Offset(0.0, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;



}





