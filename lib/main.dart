import 'package:dash_n_dine/ui/views/ProfilePage.dart';
import 'package:dash_n_dine/ui/views/loginScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: ProfilePage(
            profileImage: AssetImage('assets/profilepic.jpeg'),
            userName: 'Brayalad',
            fullName: 'Bryan Ayala',
            email: 'Blayala@cpp.edu',
            address: '1234 Living St. Pomona, CA 91145',
            phoneNumber: '555-555-5555',
            dateOfBirth: 'December 25, 2000'
        )
      )
    );
  }
}
