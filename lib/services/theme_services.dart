import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = ' isDarkMode';

  _saveThemetoBox(bool isDarkModde) => _box.write(_key, isDarkModde);
  bool _loadThemeFromBox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemetoBox(!_loadThemeFromBox());
  }
}
