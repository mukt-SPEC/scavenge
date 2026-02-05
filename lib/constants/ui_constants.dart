import 'package:flutter/material.dart';
import 'package:scavenge/features/Home/view/home_view.dart';
import 'package:scavenge/features/Scan/view/scan_view.dart';

class UiConstants {
  static List<Widget> appPages = [
    HomeView(),
    Container(),
    ScanView(),
    Container(),
    Container(),
  ];
}
