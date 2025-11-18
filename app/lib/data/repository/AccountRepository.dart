import 'dart:convert';

import 'package:http/http.dart' as http;


import '../api.dart';
import '../../utils/preferences.dart';
import '../models/Acteur.dart';
class AccountRepository{
  final String api;
  AccountRepository({required this.api});
  Acteur? acteur =  Preferences.getActorConnected();

  Future<Map<String,dynamic>> allAccounts() async{
    final url = Uri.parse(api+ Api.allAccount);
    final response = await http.get(
      url,
      headers:   {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    Map<String,dynamic> results;
    results = jsonDecode(response.body);
    return results;
  }
  Future<Map<String,dynamic>> addAccount(Map<String,dynamic> data)async{
    final url = Uri.parse(api+ Api.addAccount);
    final response =  await http.post(
      url,
      body: jsonEncode(data),
      headers:   {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    Map<String, dynamic> results ;
    results = jsonDecode(response.body);
    return results;
  }
}