import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../components/card_component.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../controllers/home_controller.dart';

List<String> operation = [
  "Cheque d'un montant de 50000F emis pour John DOE depuis votre compte UBA",
  "Cheque d'un  montant de 50000F emis  pour Rosa PARK depuis votre compte UBA",
  "Cheque d'un  montant de 50000F emis  pour Tony STARK depuis votre compte UBA",
];
List<Map<String, String>> options = [
  {
    'icon': Constants.historyIcon,
    'libelle' : "Historique des operations",
  },
  {
    'icon': Constants.fileOutlineIcon,
    'libelle' : "Emettre un cheque",
  },
  {
    'icon' : Constants.cardIcon,
    'libelle' : "Mes abornements",
  },
  {
    'icon' : Constants.logoutIcon,
    'libelle' : "Se deconnecter",
  }
];

class HomeView extends GetView<HomeController>{
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    homeController.allAccount();
    return  Scaffold(
      backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  padding:  EdgeInsets.only(top: 20, left: 0, right: 0),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        alignment:  Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFFffd1ad)
                        ),
                        child: Text("J"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.color1,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          width: double.maxFinite,
                          height: 45,
                          child: Form(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hint:Text(
                                    "Rechercher",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 45,
                        alignment:  Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color:AppColors.color1,
                              width:2,
                            )
                        ),
                        child: SvgPicture.asset(
                          Constants.notificationsIcon,
                          color: Colors.white,
                          width: 18,
                          height: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        alignment:  Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.color1
                        ),
                        child: SvgPicture.asset(
                          Constants.codeQrIcon,
                          color: Colors.white,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                            width: double.maxFinite,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Mes comptes",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        alignment:  Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.color1
                        ),
                        child: SvgPicture.asset(
                          Constants.addIcon,
                          color: Colors.white,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<HomeController>(
                    builder: (_) => (controller.accounts.isEmpty)?
                    Container(
                      height: 200,
                      width: double.maxFinite, margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      decoration: BoxDecoration(
                          color: AppColors.color1,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.5
                          )
                      ),
                      child: Column(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Vous n'avez aucun compte enregistre",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20,

                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 60,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                      color: AppColors.borderColor,
                                      width: 2
                                  ),
                                  borderRadius:  BorderRadius.circular(15)
                              ),
                              child:InkWell(
                                onTap: () {
                                  /// Add compte
                                  Map<String, dynamic> data;
                                  Get.toNamed(
                                    Routes.addAccount
                                  );
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Ajouter un compte",
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
                                        width: 40,
                                        alignment:  Alignment.center,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: AppColors.color1
                                        ),
                                        child: SvgPicture.asset(
                                          Constants.addIcon,
                                          color: Colors.white,
                                          width: 18,
                                          height: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],

                      )
                    ):SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.symmetric( horizontal: 10),
                        child: Row(
                            children: List.generate(5, (index) => CardComponent())
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 40,
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      ),
                      color: AppColors.color1,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Dernieres operations",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 20
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ...operation.map((nom) => Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(nom, style: TextStyle(color: Colors.white)),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: List.generate(options.length, (position) =>Container(
                                  height: 70,
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        alignment:  Alignment.center,
                                        height: 50,
                                        child: SvgPicture.asset(
                                          options[position]['icon']!,
                                          color: Colors.white,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          options[position]['libelle']!,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                )
                                ),
                              ),
                            )
                          ]
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}