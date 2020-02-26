import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:dash_n_dine/ui/shared/theme.dart';
import '../shared/text_styles.dart' as style;

class ProfilePage extends StatefulWidget {
	final profileImage;
	final userName;
	final fullName;
	final email;
	final address;
	final phoneNumber;
	final dateOfBirth;


	ProfilePage({
		this.profileImage,
		this.userName,
		this.fullName,
		this.email,
		this.address,
		this.phoneNumber,
		this.dateOfBirth
	});

	@override
	_ProfilePageState createState(){
		return _ProfilePageState(
			profileImage: profileImage,
			userName: userName,
			fullName: fullName,
			email: email,
			address: address,
			phoneNumber: phoneNumber,
			dateOfBirth: dateOfBirth
		);
	}
}


class _ProfilePageState extends State<ProfilePage> {
	final AssetImage profileImage;
	final String userName;
	final String fullName;
	final String email;
	final String address;
	final String phoneNumber;
	final String dateOfBirth;


	_ProfilePageState({
		this.profileImage,
		this.userName,
		this.fullName,
		this.email,
		this.address,
		this.phoneNumber,
		this.dateOfBirth
	});



	@override
	void initState(){
		super.initState();
	}


  @override
  Widget build(BuildContext context) {
		final _theme = Provider.of<ThemeDelegate>(context);

		final _backGround = Container(
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
						)
					],
				)
		);

		final _profileImageContainer = Container(
			child: Center(
				child: Container(
					height: 90.0,
					width: 90.0,
					padding: EdgeInsets.all(10.0),
					decoration: BoxDecoration(
						color: Theme.of(context).scaffoldBackgroundColor,
						borderRadius: BorderRadius.circular(100.0)
					),
					child: CircleAvatar(
						backgroundColor: Colors.white,
						backgroundImage: profileImage,
					),
				),
			),
		);

		final _userContainer = Container(
			child: Column(
				children: <Widget>[
					Text(
						userName,
						style: style.headerStyle3,
					),
					SizedBox(
						height: 10.0,
					)
				],
			),
		);

		final _emailContainer = _InfoContainer(
			title: 'Email',
			value: email,
		);

		final _phoneContainer = _InfoContainer(
			title: 'Phone',
			value: phoneNumber,
		);

		final _fullNameInkWell = _InfoInkWell(
			title: 'Name',
			value: fullName,
		);

		final _addressInkWell = _InfoInkWell(
			title: 'Address',
			value: address,
		);

		final _birthDateInkWell = _InfoInkWell(
			title: 'Date of Birth',
			value: dateOfBirth,
		);

		final _themeToggler = GestureDetector(
			onTap: (){
				_theme.toggleTheme();
			}
		);

		return Scaffold(
			body: SingleChildScrollView(
				physics: BouncingScrollPhysics(),
				child: Column(
					mainAxisSize: MainAxisSize.max,
					children: <Widget>[
						Container(
							child: Stack(
								children: <Widget>[
									_backGround,
									Container(
										child: Column(
											children: <Widget>[
												_profileImageContainer,
												SizedBox(
													height: 5.0,
												),
												Container(
													padding: EdgeInsets.symmetric(
														horizontal: 15.0
													),
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceAround,
														children: <Widget>[
															_themeToggler,
															Container(
																child: Column(
																	children: <Widget>[
																		_userContainer
																	],
																),
															)
														],
													),
												),
												SizedBox(
													height: 10.0,
												),
												Container(
													padding: EdgeInsets.symmetric(
														horizontal: 20.0
													),
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceEvenly,
														children: <Widget>[
															_emailContainer,
															Container(
																color: Colors.white.withOpacity(0.5),
																width: 1.0,
																height: 40.0,
															),
															_phoneContainer
														],
													),
												),
												SizedBox(
													height: 15.0,
												),
												ListView(
													physics: NeverScrollableScrollPhysics(),
													shrinkWrap: true,
													children: <Widget>[
														_fullNameInkWell,
														_addressInkWell,
														_birthDateInkWell
													],
												)
											],
										),
									)
								],
							),
						)
					],
				),
			),
		);
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
									value,
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
						value,
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





