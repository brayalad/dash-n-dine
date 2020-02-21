import 'package:flutter/material.dart';
import 'dart:async';

enum delegateState {
  idle_light,
  idle_dark,
  switch_light,
  switch_dark
}

class ThemeDelegate with ChangeNotifier {
  static final int _switchDelayDuration = 300;
  static final Color lightPrimary = Color(0xfffcfcff);
  static final Color darkPrimary = Colors.black;
  static final Color lightAccent = Color(0xff5563ff);
  static final Color darkAccent = Color(0xff5563ff);
  static final Color lightBG = Color(0xfffcfcff);
  static final Color darkBG = Colors.black;
  static final Color ratingBG = Colors.yellow[600];
  final ThemeData darkTheme = ThemeData(
      backgroundColor: darkBG,
      brightness: Brightness.dark,
      primaryColor: Color(0xFFBB86FC),
      hintColor: Colors.white.withOpacity(0.7),
      accentColor: Color(0xFFBB86FC),
      scaffoldBackgroundColor: darkBG,
      cursorColor: darkAccent,
      textSelectionColor: Colors.white,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            color: lightBG,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      )
  );
  final ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      brightness: Brightness.light,
      primaryColor: Colors.redAccent,
      accentColor: Colors.redAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      textSelectionColor: Colors.black,
      hintColor: Colors.grey,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            color: darkBG,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      )
  );

  ThemeData _themeData;
  delegateState delegateStateAdmin = delegateState.idle_light;

  ThemeDelegate(){
    this._themeData = lightTheme;
  }

  getDelegateAdmin() => this.delegateStateAdmin;

  toggleTheme() async {
    if(this._themeData == lightTheme){
      this.delegateStateAdmin = delegateState.switch_dark;
      notifyListeners();
      await Future.delayed(
        Duration(
          milliseconds: _switchDelayDuration
        )
      );
      this.delegateStateAdmin = delegateState.idle_dark;
      this._themeData = darkTheme;
    } else {
      this.delegateStateAdmin = delegateState.switch_light;
      notifyListeners();
      await Future.delayed(
          Duration(
              milliseconds: _switchDelayDuration
          )
      );
      this.delegateStateAdmin = delegateState.idle_light;
      this._themeData = lightTheme;
    }
    notifyListeners();
  }

  getTheme() => _themeData;

}

