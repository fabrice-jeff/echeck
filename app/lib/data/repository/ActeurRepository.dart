import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../routes/routes.dart';
import '../../utils/preferences.dart';
import '../api.dart';

class ActeurRepository{
  final String api;
  ActeurRepository({required this.api});


  Future<Map<String, dynamic>> login(Map<String,dynamic> data) async{
    final url = Uri.parse(api+ Api.login);
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {},
    );
    Map<String, dynamic> results;
    results = jsonDecode(response.body);
    return results;
  }

  Future<Map<String, dynamic>> register(Map<String,dynamic> data) async{
    final url = Uri.parse(api + Api.register);
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {},
    );
    Map<String, dynamic> results;
    results = jsonDecode(response.body);
    return results;
  }

  void logout() async{
    Preferences.prefs.clear();
    Get.offNamed(
      Routes.login,
    );
  }

  Future<Map<String,dynamic>> verificationAccount(Map<String,dynamic> data) async{
    final url = Uri.parse(api + Api.verification);
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {},
    );
    print(response.body);
    Map<String,dynamic> results;
    results = jsonDecode(response.body);
    return results;
  }

}