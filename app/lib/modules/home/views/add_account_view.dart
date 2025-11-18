import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../components/button_component.dart';
import '../../../components/password_form_field_component.dart';
import '../../../components/text_form_field_component.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../controllers/home_controller.dart';



class AddAccountView extends GetView<HomeController>{
  const AddAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
            child: Scaffold(
              backgroundColor: AppColors.color1,
              body: SafeArea(
                child: Container(
                  color: Colors.black,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        color: AppColors.color1,
                        height: 100,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [

                              InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Container(
                                  width: 50,
                                  alignment:  Alignment.center,
                                  height: 50,
                                  child: SvgPicture.asset(
                                    Constants.backArrowIcon,
                                    color: Colors.white,
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ajouter un compte bancaire",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),

                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: AddAccountForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        )
    );
  }
}

class AddAccountForm extends StatefulWidget{
  const AddAccountForm({super.key});
  State<StatefulWidget> createState() => AddAccountFormState();
}


class AddAccountFormState extends State<AddAccountForm>{
  late TextEditingController lastName;
  late TextEditingController firstName;
  late TextEditingController email;
  late TextEditingController telephone;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;

  @override
  void initState() {
    lastName = TextEditingController();
    firstName = TextEditingController();
    email = TextEditingController();
    telephone = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
              children: [

                TextFormFieldComponent(
                  label: "Iban",
                  hintText: "Votre iban",
                  controller: lastName,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Bic",
                  hintText: "Votre bic ",
                  controller: firstName,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Banque",
                  hintText: "Choisissez une banque.",
                  controller: email,
                  textColor: Colors.white,
                  borderColor: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Telephone",
                  hintText: "Votre telephone",
                  controller: telephone,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),

                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "nom" : lastName.text,
                        "prenoms": firstName.text,
                        "email" : email.text,
                        "numeroTel" : telephone.text,
                        "password": password.text,
                        "passwordConfirmation" : password.text
                      };
                    }
                  },
                  child: ButtonComponent(
                    backgroundColor: Colors.white,
                    label: "Enregistrer",
                    textColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),
        )
    );
  }

}