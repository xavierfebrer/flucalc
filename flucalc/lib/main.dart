import 'package:flucalc/util/constant.dart';
import 'package:flucalc/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack2s_flutter_util/util/app_data_provider.dart';
import 'package:hack2s_flutter_util/util/app_util.dart';
import 'package:hack2s_flutter_util/view/app/base_app.dart';

import 'di/locator.dart';

Future<void> main() async {
  await Hack2sAppUtil.runApplication(DeviceOrientation.values, FlucalcAppDataProvider(), () async {
    return await Future(() async {
      await Locator.initializeDI();
      return FlucalcApp();
    });
  });
}

class FlucalcApp extends BaseApp {
  FlucalcApp({Key? key}) : super(key: key);

  @override
  Widget getWidget() => Hack2sAppUtil.getDefaultMaterialApp(HomeScreen());
}

class FlucalcAppDataProvider extends Hack2sAppDataProvider {
  @override
  String get APP_NAME => FlucalcConstant.APP_NAME;

  @override
  Color get COLOR_PRIMARY => FlucalcConstant.COLOR_PRIMARY;

  @override
  Color get COLOR_SECONDARY => FlucalcConstant.COLOR_SECONDARY;

  @override
  Color COLOR_TEXT([bool darkMode = false]) => FlucalcConstant.COLOR_TEXT(darkMode);

  @override
  Color COLOR_TEXT_2([bool darkMode = false]) => FlucalcConstant.COLOR_TEXT_2(darkMode);

  @override
  FontWeight get TEXT_FONT_WEIGHT_LIGHT => FlucalcConstant.TEXT_FONT_WEIGHT_LIGHT;

  @override
  FontWeight get TEXT_FONT_WEIGHT => FlucalcConstant.TEXT_FONT_WEIGHT;

  @override
  FontWeight get TEXT_FONT_WEIGHT_MEDIUM => FlucalcConstant.TEXT_FONT_WEIGHT_MEDIUM;

  @override
  FontWeight get TEXT_FONT_WEIGHT_SEMI_BOLD => FlucalcConstant.TEXT_FONT_WEIGHT_SEMI_BOLD;

  @override
  FontWeight get TEXT_FONT_WEIGHT_BOLD => FlucalcConstant.TEXT_FONT_WEIGHT_BOLD;

  @override
  double get TEXT_LETTER_SPACING => FlucalcConstant.TEXT_LETTER_SPACING;

  @override
  double get TEXT_PRIMARY_FONT_SIZE => FlucalcConstant.TEXT_PRIMARY_FONT_SIZE;

  @override
  double get TEXT_SECONDARY_FONT_SIZE => FlucalcConstant.TEXT_SECONDARY_FONT_SIZE;
}
