import 'package:flutter/material.dart';

abstract class AppSizes {
  static const iconSize = 20.0;
  static const pagePadding = 16.0;
  static const appBar = kToolbarHeight;
  static const bottomNavBar = kBottomNavigationBarHeight;

  /// The initial value is set in the builder function in [MaterialApp].
  static double notchTop = 0;

  /// The initial value is set in the builder function in [MaterialApp].
  static double notchBottom = 0;

  static double notchVertical = notchTop + notchBottom;
}
