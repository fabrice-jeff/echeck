import 'package:app/modules/authenticator/controllers/authenticator_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../components/password_form_field_component.dart';
import '../../../components/text_form_field_component.dart';
import '../../../routes/routes.dart';

class RegisterView extends GetView{
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticatorController controller = Get.put(AuthenticatorController());
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: RegisterForm(authenticatorController: controller)
          )
      ),
    );
  }
}

class RegisterForm extends StatefulWidget{
  final AuthenticatorController authenticatorController;
  const RegisterForm({super.key, required this.authenticatorController});
  @override
  State<StatefulWidget> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm>{
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
                Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormFieldComponent(
                  label: "Nom",
                  hintText: "Votre nom ",
                  controller: lastName,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Prenom(s)",
                  hintText: "Votre prenom ",
                  controller: firstName,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Email",
                  hintText: "Votre adresse email",
                  controller: email,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  label: "Telephone",
                  hintText: "Votre telephone",
                  controller: telephone,
                ),
                SizedBox(
                  height: 30,
                ),
                PasswordFormFieldComponent(
                  label: "Mot de passe",
                  hintText: "Votre mot de passe",
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                  ),
                  controller: password,
                ),
                SizedBox(
                  height: 30,
                ),
                PasswordFormFieldComponent(
                  label: "Confirmation du mot de passe",
                  hintText: "Confirmez votre mot de passe",
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                  ),
                  controller: passwordConfirmation,
                ),
                SizedBox(
                  height: 20,
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
                      widget.authenticatorController.register(data);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:  BorderRadius.circular(100)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "J'ai deja un compte. "
                          ),
                          InkWell(
                            onTap: (){

                              Get.offAllNamed(
                                  Routes.login
                              );
                            },
                            child: Text(
                                "Se connecter"
                            ),
                          )
                        ]
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
  
}