
import '../../services/datetime_format.dart';

class Bank{
  final int? id;
  final String libelle;
  final DateTime createdAt;
  final DateTime updatedAt;

  Bank({
    this.id,
    required this.libelle,
    required this.createdAt,
    required this.updatedAt
  });

  factory Bank.fromJson(Map<String,dynamic> json){
    return Bank(
        libelle: json['libelle'],
        createdAt: dateTimeFormat(json['created_at']),
        updatedAt: dateTimeFormat(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }



}