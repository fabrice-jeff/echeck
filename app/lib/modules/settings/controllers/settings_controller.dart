import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/ActeurRepository.dart';

class SettingsController extends GetxController{
  final acteurRepository = ActeurRepository(api: Api.baseUrl);

  /// Deconnexion de l'utilisateur
  void logout(){
      acteurRepository.logout();
  }
}