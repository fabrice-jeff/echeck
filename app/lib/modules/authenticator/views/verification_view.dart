import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authenticator_controller.dart';

class VerificationView extends GetView{
  final String? email;
  const VerificationView({super.key, this.email});
  @override
  Widget build(BuildContext context) {
    final AuthenticatorController authenticatorController = Get.put(AuthenticatorController());
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: VerificationForm(authenticatorController: authenticatorController, email: email!,),
        ),
      ),
    );
  }
}
class VerificationForm extends StatefulWidget{
  final AuthenticatorController authenticatorController;
  final String email;
  const VerificationForm({super.key, required this.authenticatorController, required this.email});
  @override
  State<StatefulWidget> createState() => VerificationFormState();

}

class VerificationFormState extends State<VerificationForm>{
  late TextEditingController _otpController1;
  late TextEditingController _otpController2;
  late TextEditingController _otpController3;
  late TextEditingController _otpController4;
  late TextEditingController _otpController5;
  late TextEditingController _otpController6;

  @override
  void initState() {
    _otpController1 = TextEditingController();
    _otpController2 = TextEditingController();
    _otpController3 = TextEditingController();
    _otpController4 = TextEditingController();
    _otpController5 = TextEditingController();
    _otpController6 = TextEditingController();
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
          child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child:Text(
                      "Entrez le code de verification a six chiffres envoye sur votre email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                      ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  // padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(
                              first: true,
                              last: false,
                              controller: _otpController1),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController2),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController3),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController4),
                          _textFieldOTP(
                              first: false,
                              last: false,
                              controller: _otpController5
                          ),
                          _textFieldOTP(
                              first: false,
                              last: true,
                              controller: _otpController6
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var code = _otpController1.text+_otpController2.text+_otpController3.text+_otpController4.text+_otpController5.text+_otpController6.text;
                      Map<String, dynamic> data ={
                        "email" : widget.email,
                        "code":code
                      };
                      widget.authenticatorController.verificationAccount(data);
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
                      "Verifier",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
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
                      "Je n'ai pas recu de code",
                      textAlign: TextAlign.end ,
                      style: TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),

              ],
          ),
        ),
      ),
    );
  }


  Widget _textFieldOTP({
    TextEditingController? controller,
    bool? first,
    last,
  }) {
    return Expanded(
      child: Container(
        height: 60,
        margin: EdgeInsets.all(5),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

