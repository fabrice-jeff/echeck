import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    final BaseController controller = Get.put(BaseController());
    return GetBuilder<BaseController>(
      builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: AppColors.color1,
          body: SafeArea(
            child: IndexedStack(
              index: controller.currentIndex,
              children: [
                HomeView(),
                ProfileView(),
                SettingsView(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: 0.2),
            decoration: BoxDecoration(
              color:  Color(0xFF8e8e8e),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: AppColors.color1,
                currentIndex: controller.currentIndex,
                type: BottomNavigationBarType.fixed,
                elevation: 0.0,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedFontSize: 0.0,
                items: [
                  _mBottomNavItem(
                    label: 'Home',
                    icon: Constants.homeIcon,
                  ),
                  _mBottomNavItem(
                    label: 'User',
                    icon: Constants.userIcon,
                  ),
                  _mBottomNavItem(
                    label: 'Settings',
                    icon: Constants.settingsIcon,
                  ),
                ],
                onTap: controller.changeScreen,
              ),
            ),
          ),
        ),
      )
    );
  }
  _mBottomNavItem({required String label, required String icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        color: Color(0xFF8e8e8e),
        width: 25,
        height: 25,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        color: Color(0xFFa498ea),
        width: 25,
        height: 25,
      ),
    );
  }
}

