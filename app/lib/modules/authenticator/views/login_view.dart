import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/password_form_field_component.dart';
import '../../../components/text_form_field_component.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../controllers/authenticator_controller.dart';

class LoginView extends GetView{
  const LoginView({super.key, });
  @override
  Widget build(BuildContext context) {
    AuthenticatorController controller = Get.put(AuthenticatorController());
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: LoginForm(
              controller: controller,
            )
          )
      ),
    );
  }}

class LoginForm extends StatefulWidget{
  final AuthenticatorController controller;
  const LoginForm({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Se connecter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormFieldComponent(
                label: "Email",
                hintText: "Votre adresse email",
                prefixIcon: Icon(Icons.mail_outline, size: 40) ,
                controller: username,
              ),
              SizedBox(
                height: 50,
              ),
              PasswordFormFieldComponent(
                label:"Password",
                hintText: "Votre mot de passe",
                prefixIcon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SvgPicture.asset(
                    Constants.key,
                    width: 1,
                    height: 1,
                  ),
                ),
                suffixIcon: Icon(Icons.remove_red_eye),
                controller: password,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                   "Mot de passe oublié ?",
                    textAlign: TextAlign.end  ,
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:  BorderRadius.circular(100)
                ),
                alignment: Alignment.center,
                child:InkWell(
                  onTap: () {

                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'email' :username.text,
                        'password' : password.text
                      };
                      widget.controller.login(data);
                    }

                  },
                  child: Text(
                    "Login",
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
                        "Pas encore de compte? "
                    ),
                    InkWell(
                      onTap: (){

                        Get.offAllNamed(
                          Routes.register
                        );
                      },
                      child: Text(
                          "Creer un compte"
                      ),
                    )
                  ]
                )
              )
            ],
          ),
        ),
      ),
    );
  }

}