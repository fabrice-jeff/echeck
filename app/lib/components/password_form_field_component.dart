import 'package:flutter/material.dart';

class PasswordFormFieldComponent extends StatelessWidget{
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final Color borderColor;
  const PasswordFormFieldComponent({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = true,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                obscureText: obscureText,
                controller: controller,
                style: TextStyle(
                  fontSize: 20
                ),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: (prefixIcon != null )?  prefixIcon : null,
                  hintText: hintText,
                  suffixIcon:(suffixIcon != null )?  suffixIcon: null,
                ),
              )
            ],
          ),
        )
    );

  }
  
}