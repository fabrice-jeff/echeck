import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/Acteur.dart';

class Preferences {


  Preferences._();
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Acteur? getActorConnected() {
    String? acteurJson = prefs.getString('acteur');
    Acteur? acteur;
    if (acteurJson != null) {
      acteur = Acteur.fromJson(jsonDecode(acteurJson));
    }
    return acteur;
  }
}
