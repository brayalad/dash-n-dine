import 'dart:io';
import 'package:dash_n_dine/ui/widgets/FileUploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class ImageCapture extends StatefulWidget {
	createState() => _ImageCaptureState();
}


class _ImageCaptureState extends State<ImageCapture> {
	File _file;


	Future<void> _cropImage() async {
		File cropped = await ImageCropper.cropImage(
				sourcePath: _file.path
		);

		setState(() {
		  _file = cropped ?? _file;
		});
	}

	Future<void> _pickImage(ImageSource source) async {
		File selected = await ImagePicker.pickImage(source: source);

		setState(() {
		  _file = selected;
		});
	}

	void _clear(){
		setState(() => _file = null);
	}

  @override
  Widget build(BuildContext context) {
		return Scaffold(
			bottomNavigationBar: BottomAppBar(
				child: Row(
					children: <Widget>[
						IconButton(
							icon: Icon(Icons.home),
							onPressed: () => Navigator.pushReplacementNamed(context, '/mainPage') ,
						),
						IconButton(
							icon: Icon(Icons.photo_camera),
							onPressed: () => _pickImage(ImageSource.camera),
						),
						IconButton(
							icon: Icon(Icons.photo_library),
							onPressed: () => _pickImage(ImageSource.gallery),
						)
					],
				),
			),
			body: ListView(
				children: <Widget>[
					if(_file != null) ...[
						Image.file(_file),
						Row(
							children: <Widget>[
								FlatButton(
									child: Icon(Icons.crop),
									onPressed: _cropImage,
								),
								FlatButton(
									child: Icon(Icons.refresh),
									onPressed: _clear,
								)
							],
						),
						FileUploader(file: _file)
					]
				],
			),
		);
  }

}

