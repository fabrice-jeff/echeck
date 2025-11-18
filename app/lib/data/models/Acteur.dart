import '../../services/datetime_format.dart';

class Acteur{
   final int? id;
   final String name;
   final String prenoms;
   final String email;
   final String telephone;
   final String token;
   final DateTime createdAt;
   final DateTime updatedAt;

   Acteur({
     this.id,
     required this.name,
     required this.prenoms,
     required this.telephone,
     required this.email,
     required this.token,
     required this.createdAt,
     required this.updatedAt,
   });

   factory Acteur.fromJson(Map<String, dynamic> json) {
     return Acteur(
         id: json['id'],
         name: json['nom'],
         prenoms: json['prenoms'],
         telephone: json['telephone'],
         email: json['email'],
         token: json['token'],
         createdAt: dateTimeFormat(json['created_at']),
         updatedAt: dateTimeFormat(json['updated_at'])
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'nom': name,
       'prenoms':prenoms,
       'telephone': telephone,
       'email': email,
       'token': token,
       'created_at': createdAt.toString(),
       'updated_at': updatedAt.toString()
     };
   }



}