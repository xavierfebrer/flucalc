import 'package:flucalc/view/screen/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlucalcNavigator {
  static FlucalcNavigator _instance;

  static FlucalcNavigator getInstance() {
    if (_instance == null) _instance = FlucalcNavigator();
    return _instance;
  }

  void navigateToHome(BuildContext context, [bool clearStack = true]) {
    _navigateToScreen(context, HomeScreen(), clearStack);
  }

  void _navigateToScreen(BuildContext context, Widget screen, [bool clearStack = true]) {
    var route = MaterialPageRoute(builder: (context) => screen);
    if (clearStack) {
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    } else {
      Navigator.of(context).push(route);
    }
  }
}
