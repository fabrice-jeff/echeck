
import 'dart:convert';

import 'package:app/data/models/Bank.dart';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/models/Account.dart';
import '../../../data/models/Acteur.dart';
import '../../../data/repository/AccountRepository.dart';
import '../../../utils/preferences.dart';

class HomeController extends GetxController{
  final AccountRepository accountRepository = AccountRepository(api: Api.baseUrl);
  Acteur? acteur =  Preferences.getActorConnected();
  List<Account> accounts = [];
  void allAccount()async{
    final response = await  accountRepository.allAccounts();
    if(response['code'] == 200){
      /// creating objet account
      for(var account in response['data'] ){
        Map<String, dynamic> bank = account['banque'];
        bank['created_at'] = account['banque']['createdAt'];
        bank['updated_at'] = account['banque']['updatedAt'];
        Map<String, dynamic> data ={
          'id': account['id'],
          'iban': account['iban'],
          'bic': account['bic'],
          'date_expiration': account['dateExpiration'],
          'actor': jsonEncode(acteur!),
          'bank': jsonEncode(Bank.fromJson(bank)),
          "created_at": account['createdAt'],
          'updated_at': account['updatedAt']
        };
        Account accountObjet = Account.fromJson(data);
        accounts.add(accountObjet);
      }
    }
    update();
  }

  void addAccount(Map<String,dynamic> data) async{
    final response = await accountRepository.addAccount(data);
    if(response['code'] == 201){
      allAccount();
    }
  }
}