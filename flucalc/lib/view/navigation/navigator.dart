import 'package:flucalc/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hack2s_flutter_util/view/navigation/navigator.dart';

class FlucalcNavigator {

  void navigateToHome(BuildContext context, [bool clearStack = true]) {
    Hack2sNavigator.navigateToScreen(context, HomeScreen(), clearStack);
  }
}
