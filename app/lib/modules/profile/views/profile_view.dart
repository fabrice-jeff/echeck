import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../controllers/profile_controller.dart';
List<Map<String, String?>> options = [
  {
    'icon' : Constants.userIcon,
    'libelle' : "John DOE",
    'suffix' : null,
  },
  {
    'icon' : Constants.mailIcon,
    'libelle' : "johndoe@gmail.com",
    'suffix' : null,
  },
  {
    'icon': Constants.cardIcon,
    'libelle' : "Nombre d'abonnement",
    'suffix' : '02'
  },
  {
    'icon': Constants.accountIcon,
    'libelle' : "Nombre de compte",
    'suffix' : '03'
  },
  {
    'icon': Constants.fileIcon,
    'libelle' : "Nombre de cheque genere",
    'suffix' : '13'
  },
  {
    'icon': Constants.phoneIcon,
    'libelle' : "+22990000009",
    'suffix' : null
  }

];
class ProfileView extends GetView<ProfileController>{
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
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
                      "Profile",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 17
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Colors.white,
                              width: 15
                          ),
                        ),
                        child: Container(
                          width: 130,
                          height: 130,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: Color(0xFFa5a627),
                                width: 8
                            ),
                          ),
                          child: SvgPicture.asset(
                            Constants.manIcon,
                            width: 2,
                            height: 22,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.only(top: 90, left: 90),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: AppColors.borderColor,
                                width: 2
                            )
                        ),
                        child: SvgPicture.asset(
                          Constants.cameraIcon,
                          color: Colors.white,
                          width: 2,
                          height: 2,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: List.generate(options.length, (position) =>Container(
                        height: 70,
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
                            ) : (position == options.length-1) ?  BorderRadius.only(
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
                                options[position]['icon']!,
                                color: Colors.white,
                                width: 22,
                                height: 22,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  options[position]['libelle']!,
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
                      (options[position]['suffix'] != null) ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                options[position]['suffix']!,
                                style: TextStyle(
                                    color: Color(0xFFffd1ad),
                                    fontSize: 20
                                ),
                              ),
                            ) : Container(),
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
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.color1,
                        border: Border.all(
                            color: AppColors.borderColor,
                            width: 2
                        ),
                        borderRadius:  BorderRadius.circular(15)
                    ),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          alignment:  Alignment.center,
                          height: 50,
                          child: SvgPicture.asset(
                            Constants.editIcon,
                            color: Colors.white,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Modifier mes informations",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}