import 'dart:convert';

import '../../services/datetime_format.dart';
import 'Acteur.dart';
import 'Bank.dart';

class Account{
  final int? id;
  final String iban;
  final String bic;
  final DateTime dateExpiration;
  final Acteur actor;
  final Bank bank;
  final DateTime createdAt;
  final DateTime updatedAt;

  Account({
    this.id,
    required this.iban,
    required this.bic,
    required this.dateExpiration,
    required this.actor,
    required this.bank,
    required this.createdAt,
    required this.updatedAt
  });
  factory Account.fromJson(Map<String,dynamic> json){
    return Account(
        id: json['id'],
        iban: json['iban'],
        bic: json['bic'],
        dateExpiration: dateTimeFormat(json['date_expiration']),
        actor: Acteur.fromJson(jsonDecode(json['actor'])),
        bank: Bank.fromJson(jsonDecode(json['bank'])),
        createdAt: dateTimeFormat(json['created_at']),
        updatedAt: dateTimeFormat(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson(){
    return {


    };
  }





}