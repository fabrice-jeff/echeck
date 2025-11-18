import 'package:app/modules/home/views/home_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../controllers/settings_controller.dart';

List<Map<String, dynamic>> optionsThemes = [
  {
    'icon': Constants.automaticIcon,
    'libelle' : "Automatic",
    'state' : true,
  },
  {
    'icon': Constants.darkIcon,
    'libelle' : "Dark",
    'state' : false,
  },
  {
    'icon': Constants.lightIcon,
    'libelle' : "Light",
    'state' : false,
  },
];

List<Map<String, dynamic>> optionsInformations = [
  {
    'libelle' : "App Name",
    'value' : Constants.nameApp
  },
  {
    'libelle': "Version",
    'value' :   Constants.versionApp,
  },
  {
    'libelle': "Feed back",
    'value' : 'u',
  },
];
class SettingsView extends GetView<SettingsController>{
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.zero,
            child:SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    color: AppColors.color1,
                    height: 100,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Theme",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: List.generate(optionsThemes.length, (position) =>Container(
                          height: 60,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.color1,
                              border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 2
                              ),
                              borderRadius: (position == 0) ? BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)
                              ) : (position == optionsThemes.length-1) ?  BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)
                              ) :BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(0)
                              )
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                alignment:  Alignment.center,
                                height: 50,
                                child: SvgPicture.asset(
                                  optionsThemes[position]['icon'],
                                  color: Colors.white,
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    optionsThemes[position]['libelle'],
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                child:   RoundCheckBox(
                                  isChecked: optionsThemes[position]['state'],
                                  uncheckedColor: Colors.transparent,
                                  border: Border.all(
                                      color: Color(0xFF8e8e8e),
                                      width: 2
                                  ),
                                  checkedWidget: Center(
                                    child: Icon(
                                      Icons.circle,
                                      color:  Color(0xFFa498ea),
                                      size: 15,
                                    ),
                                  ),
                                  checkedColor: Colors.transparent,
                                  onTap: (selected) {
                                  },
                                 size: 27,
                                )
                              )
                            ],
                          )
                      )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Informations sur le compte",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: List.generate(optionsInformations.length, (position) =>Container(
                          height: 70,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.color1,
                              border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 2
                              ),
                              borderRadius: (position == 0) ? BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              ) : (position == optionsInformations.length-1) ?  BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ) :BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(0)
                              )
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  optionsInformations[position]['libelle'],
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  optionsInformations[position]['value'],
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child:Text(
                      "Se deconnecter",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16
                      ),
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 60,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.color1,
                          border: Border.all(
                              color: AppColors.borderColor,
                              width: 2
                          ),
                          borderRadius:  BorderRadius.circular(15)
                      ),
                      child:InkWell(
                        onTap: () {
                          controller.acteurRepository.logout();
                        },
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Se deconnecter",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 50,
                                alignment:  Alignment.center,
                                height: 50,
                                child: SvgPicture.asset(
                                  Constants.logoutIcon,
                                  color: Colors.white,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Supprimer le compte",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.color1,
                        border: Border.all(
                            color: AppColors.borderColor,
                            width: 2
                        ),
                        borderRadius:  BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Supprimer le compte",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 25
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.justify,
                            "Cette action est irreversible. Elle  supprimera definitivement votre compte ainsi que toute les donnees qui y sont.",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF3d1515),
                              border: Border.all(
                                  color: Color(0xFFac4641),
                                  width: 2
                              ),
                              borderRadius:  BorderRadius.circular(10)
                          ),
                          child:Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(
                                  width: 50,
                                  alignment:  Alignment.center,
                                  height: 50,
                                  child: SvgPicture.asset(
                                    Constants.logoutIcon,
                                    color: Colors.white,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Supprimer mon compte",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        )
                      ],
                    )
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          )
      ),
    );
  }

}