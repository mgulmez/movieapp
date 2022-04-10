import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storage.dart';

class ThemeBLOC extends Cubit<ThemeMode> {
  ThemeBLOC() : super(Storage.instance.themeMode);
  void toggle() {
    Storage.instance.themeMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(Storage.instance.themeMode);
  }
}
