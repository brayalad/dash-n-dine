import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/db/UsersCollection.dart';
import 'package:dash_n_dine/core/location/LocationService.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:dash_n_dine/ui/shared/theme.dart';
import 'package:dash_n_dine/ui/widgets/FileDownloader.dart';
import 'package:dash_n_dine/ui/widgets/TitleAppBar.dart';
import 'package:dash_n_dine/ui/widgets/UpdateInfoTextFieldDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../shared/text_styles.dart' as style;

class SettingsPage extends StatefulWidget {

	@override
	_SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
	LocationService _location = LocationService();

	final _users = UsersCollection.instance;
	final _auth = Auth.instance;
	final _loader = FileDownloader.instance;

	User user;
	ImageProvider image;

	bool _notifications = true;
	bool _dark;


	@override
	void initState() {
		super.initState();
		_dark = false;
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

	Brightness _getBrightness() {
		return _dark ? Brightness.dark : Brightness.light;
	}

	Future<String> createLocationInputDialog(BuildContext context, String prompt) async {
		TextEditingController _textFieldController = TextEditingController();

		var actions = [
			FlatButton(
				child: Text('CANCEL'),
				onPressed: () {
					Navigator.of(context).pop();
				},
			),
			FlatButton(
				child: Text('SUBMIT'),
				onPressed: () {
					Navigator.of(context).pop(_textFieldController.text.toString());
				},
			),
			FlatButton(
				child: Icon(Icons.my_location),
				onPressed: (){
					_location.getCurrentLocationAddress().then((value) {
						Navigator.of(context).pop(value);
					});
				},
			)
		];

		return showDialog(
				context: context,
				builder: (context) {
					return AlertDialog(
						title: Text(prompt),
						content: TextField(
							controller: _textFieldController,
							decoration: InputDecoration(),
						),
						actions: actions,
					);
				});
	}

	Future<String> createInputDialog(BuildContext context, String prompt) async {
		TextEditingController _textFieldController = TextEditingController();

		var actions = [
			FlatButton(
				child: Text('CANCEL'),
				onPressed: () {
					Navigator.of(context).pop();
				},
			),
			FlatButton(
				child: Text('SUBMIT'),
				onPressed: () {
					Navigator.of(context).pop(_textFieldController.text.toString());
				},
			)
		];

		return showDialog(
				context: context,
				builder: (context) {
					return AlertDialog(
						title: Text(prompt),
						content: TextField(
							controller: _textFieldController,
							decoration: InputDecoration(),
						),
						actions: actions,
					);
				});
	}

	@override
	Widget build(BuildContext context) {

		final theme = Provider.of<ThemeDelegate>(context);

		_dark = theme.getTheme() == theme.darkTheme;

		if(user == null || image == null){
			return new Container();
		} else {
			return Theme(
				isMaterialAppTheme: true,
				data: ThemeData(
					brightness: _getBrightness(),
				),
				child: Scaffold(
					backgroundColor: Theme.of(context).backgroundColor,
					appBar: TitleAppBar(title: 'Settings'),
					body: Stack(
						fit: StackFit.expand,
						children: <Widget>[
							SingleChildScrollView(
								padding: const EdgeInsets.all(16.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Card(
											elevation: 8.0,
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(10.0)),
											color: Theme.of(context).primaryColor,
											child: ListTile(
												onTap: () {
													//open edit profile
												},
												title: Text(
													user.username,
													style: TextStyle(
														color: Colors.white,
														fontWeight: FontWeight.w500,
													),
												),
												leading: InkWell(
													child: CircleAvatar(
														backgroundImage: image,
													),
													onTap: () {
														Navigator.pushNamed(context, '/imageCapture');
													},
												),
												trailing: IconButton(
													icon: Icon(Icons.edit),
													onPressed: () {
														createInputDialog(context, 'Enter Username').then((val) {
															user.username = val;
															//user.photoUrl = 'gs://dash-n-dine.appspot.com/images/${user.username}_profile_pic';
															_users.updateUser(user);
														});
													},
												),
											),
										),
										const SizedBox(height: 10.0),
										Card(
											elevation: 4.0,
											margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(10.0)
											),
											child: Column(
												children: <Widget>[
													ListTile(
														leading: Icon(
															Icons.email,
															color: Theme.of(context).primaryColor,
														),
														title: Text("Change Email"),
														trailing: Icon(Icons.keyboard_arrow_right),
														onTap: () {

														},
													),
													_buildDivider(),
													ListTile(
														leading: Icon(
															Icons.lock_outline,
															color: Theme.of(context).primaryColor,
														),
														title: Text("Change Password"),
														trailing: Icon(Icons.keyboard_arrow_right),
														onTap: () {
															//open change language
														},
													),
													_buildDivider(),
													ListTile(
														leading: Icon(
															Icons.location_on,
															color: Theme.of(context).primaryColor,
														),
														title: Text("Change Location"),
														trailing: Icon(Icons.keyboard_arrow_right),
														onTap: () {
															createLocationInputDialog(context, 'Enter Address')
																	.then((val) {
																		user.setAddress(val);
																		_users.updateUser(user);
															});
														},
													),
													_buildDivider(),
													ListTile(
														leading: Icon(
															Icons.phone_iphone,
															color: Theme.of(context).primaryColor,
														),
														title: Text("Change Phone Number"),
														trailing: Icon(Icons.keyboard_arrow_right),
														onTap: () {
															createInputDialog(context, 'Enter Phone Number').then((val) {
																user.setPhoneNumber(val);
																_users.updateUser(user);
															});
														},
													),
													_buildDivider(),
													ListTile(
														leading: Icon(
															Icons.calendar_today,
															color: Theme.of(context).primaryColor,
														),
														title: Text("Change Birthday"),
														trailing: Icon(Icons.keyboard_arrow_right),
														onTap: () {
															createInputDialog(context, 'Enter Birthday').then((val) {
																user.setDateOfBirth(val);
																_users.updateUser(user);
															});
														},
													),
												],
											),
										), 
										const SizedBox(height: 20.0),
										Text(
											"Settings",
											style: TextStyle(
												fontSize: 20.0,
												fontWeight: FontWeight.bold,
												color: Theme.of(context).primaryColor,
											),
										),
										SwitchListTile(
											activeColor: Theme.of(context).primaryColor,
											contentPadding: const EdgeInsets.all(0),
											value: _dark,
											title: Text(
													"Dark Mode",
													style: style.headerStyle3
											),
											onChanged: (val) {
												setState(() {
												  _dark = val;
												  theme.toggleTheme();
												});
											},
										),
										SwitchListTile(
											activeColor: Theme.of(context).primaryColor,
											contentPadding: const EdgeInsets.all(0),
											value: _notifications,
											title: Text(
													"Notifications",
													style: style.headerStyle3
											),
											onChanged: (val) {
												setState(() {
												  _notifications = val;
												});
											},
										),
										SwitchListTile(
											activeColor: Theme.of(context).primaryColor,
											contentPadding: const EdgeInsets.all(0),
											value: true,
											title: Text(
													"Offer Notifications",
													style: style.headerStyle3
											),
											onChanged: null,
										),
										SwitchListTile(
											activeColor: Theme.of(context).primaryColor,
											contentPadding: const EdgeInsets.all(0),
											value: true,
											title: Text(
													"App Updates",
													style: style.headerStyle3
											),
											onChanged: null,
										),
										const SizedBox(height: 60.0),
									],
								),
							),
							Positioned(
								bottom: -20,
								left: -20,
								child: Container(
									width: 80,
									height: 80,
									alignment: Alignment.center,
									decoration: BoxDecoration(
										color: Theme.of(context).primaryColor,
										shape: BoxShape.circle,
									),
								),
							),
							Positioned(
								bottom: 00,
								left: 00,
								child: IconButton(
									icon: Icon(
										FontAwesomeIcons.powerOff,
										color: Colors.white,
									),
									onPressed: () {
										//log out
									},
								),
							)
						],
					),
				),
			);
		}
	}

	Container _buildDivider() {
		return Container(
			margin: const EdgeInsets.symmetric(
				horizontal: 8.0,
			),
			width: double.infinity,
			height: 1.0,
			color: Colors.grey.shade400,
		);
	}
}





