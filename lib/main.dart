import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_immersive_od/app_module.dart';
import 'package:nasa_immersive_od/app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    ModularApp(
        module: AppModule(await SharedPreferences.getInstance()),
        child: const AppWidget()),
  );
}
