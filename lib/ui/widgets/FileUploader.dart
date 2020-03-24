import 'dart:io';
import 'package:dash_n_dine/core/auth/Auth.dart';
import 'package:dash_n_dine/core/auth/BasicAuth.dart';
import 'package:dash_n_dine/core/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileUploader extends StatefulWidget {
	final File file;

	FileUploader({Key key, this.file}) : super(key: key);

	createState() => _FileUploaderState();

}


class _FileUploaderState extends State<FileUploader> {
	static final String _storageURL = 'gs://dash-n-dine.appspot.com';

	final FirebaseStorage _storage = FirebaseStorage(storageBucket: _storageURL);
	final Auth _auth = BasicAuth();

	StorageUploadTask _uploadTask;

	void _startUpload() async {

		User user = await _auth.getCurrentUser();

		String path = 'images/${user.username}_profile_pic';

		setState(() {
		  _uploadTask = _storage.ref().child(path).putFile(widget.file);
		});
	}




  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){

    	return StreamBuilder<StorageTaskEvent>(
		    stream: _uploadTask.events,
		    builder: (_, snapshot) {
		    	var event = snapshot?.data?.snapshot;

		    	double progress = (event != null) ? (event.bytesTransferred / event.totalByteCount) : 0;

		    	return Column(
				    children: <Widget>[
				    	if(_uploadTask.isComplete)
				    		FlatButton(
							    child: Icon(Icons.cloud_done),
							    onPressed: () {
								    Navigator.pushReplacementNamed(
										    context, '/mainPage'
								    );
							    },
						    ),

					    if(_uploadTask.isPaused)
					    	FlatButton(
							    child: Icon(Icons.play_arrow),
							    onPressed: _uploadTask.resume,
						    ),

					    if(_uploadTask.isInProgress)
					    	FlatButton(
							    child: Icon(Icons.pause),
							    onPressed: _uploadTask.pause,
						    ),

					    LinearProgressIndicator(value: progress),
					    Text('${(progress * 100).toStringAsFixed(2)}%')

				    ],
			    );
		    }
	    );



    } else {
    	return FlatButton.icon(
		    label: Text('Upload'),
		    icon: Icon(Icons.cloud_upload),
		    onPressed: _startUpload,
	    );
    }


  }

}




