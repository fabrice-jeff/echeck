import 'package:get/get.dart';

import '../modules/authenticator/bindings/authenticator_binding.dart';
import '../modules/authenticator/views/login_view.dart';
import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_view.dart';
import '../modules/authenticator/views/register_view.dart';
import '../modules/authenticator/views/verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/add_account_view.dart';
import 'routes.dart';

class AppPage {
  AppPage._();
  static final INITIAL = Routes.login;
  static final routes = [
    GetPage(
      name: Routes.base,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding:AuthenticatorBinding()
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthenticatorBinding(),
    ),
    GetPage(
      name: Routes.verification,
      page: () => const VerificationView(),
      binding: AuthenticatorBinding(),
    ),
    GetPage(
      name: Routes.addAccount,
      page: () => const AddAccountView(),
      binding: HomeBinding(),
    ),
  ];
}
