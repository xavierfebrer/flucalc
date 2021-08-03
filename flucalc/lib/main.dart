import 'package:flucalc/util/constant.dart';
import 'package:flucalc/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack2s_flutter_util/util/app_util.dart';
import 'package:hack2s_flutter_util/view/app/base_app.dart';

void main() {
  Hack2sAppUtil.runApplication([DeviceOrientation.portraitUp], () => FlucalcApp());
}

class FlucalcApp extends BaseApp {
  FlucalcApp({Key? key}) : super(key: key);

  @override
  Widget getWidget() => Hack2sAppUtil.getDefaultMaterialApp(
      FlucalcConstant.APP_NAME, Hack2sAppUtil.getDefaultThemeData(FlucalcConstant.COLOR_PRIMARY, FlucalcConstant.COLOR_ACCENT), HomeScreen());
}
