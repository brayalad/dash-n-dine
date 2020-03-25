import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateInfoTextFieldDialog extends StatelessWidget {
	TextEditingController _textFieldController = TextEditingController();

	_displayDialog(BuildContext context) async {
		return showDialog(
				context: context,
				builder: (context) {
					return AlertDialog(
						title: Text('TextField in Dialog'),
						content: TextField(
							controller: _textFieldController,
							decoration: InputDecoration(hintText: "TextField in Dialog"),
						),
						actions: <Widget>[
							new FlatButton(
								child: new Text('CANCEL'),
								onPressed: () {
									Navigator.of(context).pop();
								},
							)
						],
					);
				});
	}

	@override
	Widget build(BuildContext context) {
		return _displayDialog(context);
	}
}