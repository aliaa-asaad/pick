import 'package:pick_up/routing/navigator.dart';
import 'package:flutter/cupertino.dart';

abstract class MediaQueryHelper {
  static double width =
      MediaQuery.of(AppRoutes.navigatorState.currentContext!).size.width;
  static double height =
      MediaQuery.of(AppRoutes.navigatorState.currentContext!).size.height;
}
