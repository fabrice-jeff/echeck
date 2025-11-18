import 'dart:convert';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/models/Acteur.dart';
import '../../../data/repository/ActeurRepository.dart';
import '../../../routes/routes.dart';
import '../../../services/datetime_format.dart';
import '../../../utils/preferences.dart';
import '../views/verification_view.dart';

class AuthenticatorController extends GetxController{
  final acteurRepository = ActeurRepository(api: Api.baseUrl);

  /// Permettre de se connecter
  void login(Map<String, dynamic> data) async {
    final result = await acteurRepository.login(data);
    if (result['code'] == 200) {
      Map<String, dynamic> response = result['data'];
      /// Creation de l'objet Acteur
      final acteur = new Acteur(
          id: response['acteur']['id'] ,
          name: response['acteur']['nom'],
          prenoms: response['acteur']['prenoms'],
          telephone: response['acteur']['numero'],
          email: response['acteur']['email'],
          token: response['token'],
          createdAt: dateTimeFormat(response['acteur']['createdAt']),
          updatedAt: dateTimeFormat(response['acteur']['updatedAt'])
      );
      Preferences.prefs.setString('acteur', jsonEncode(acteur));
      /// Retour sur la route de base
      Get.offAllNamed(
        Routes.base,
      );
    } else {
      /// Retourner sur la page de connexion avec les erreurs
    }
  }
  /// Registration of the user
  void register(Map<String, dynamic> data) async{
    final result = await acteurRepository.register(data);
    if (result['code'] == 201) {
      Map<String, dynamic> response = result['data'];
      Get.offAll(
          () => VerificationView(email: response['email'])
      );
    } else {
      Get.offAllNamed(
        Routes.register,
      );
    }
  }

  /// Verification of the account
  void verificationAccount(Map<String, dynamic> data)async {
    final result = await acteurRepository.verificationAccount(data);
    Map<String, dynamic> response = result['data'];

    if (result['code'] == 200) {
      Get.offAllNamed(
        Routes.login,
      );
    } else {
      Get.offAll(
              () => VerificationView(email: data['email'])
      );
    }

  }
}