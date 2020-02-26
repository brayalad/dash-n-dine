import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './ui/router.dart';

import 'locator.dart';
import 'package:provider/provider.dart';
import './ui/shared/theme.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeDelegate>(
      create: (_) => ThemeDelegate(),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  @override
  _MaterialAppWithThemeState createState() => _MaterialAppWithThemeState();
}


class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeDelegate>(context);
    return MultiProvider(
      providers: [
      ],
      child: MaterialApp(
        onGenerateRoute: Router.generateRoute,
        initialRoute: '/splashPage',
        theme: theme.getTheme(),
        title: 'Dash N Dine',
      ),
    );
  }
}

