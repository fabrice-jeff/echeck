import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget{
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final Color borderColor;
  final Color textColor;
  const TextFormFieldComponent({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.borderColor = Colors.black,
    this.prefixIcon,
    this.textColor = Colors.black
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
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 1.5,
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
                  hintStyle: TextStyle(
                    color: textColor
                  ),
                  suffixIcon:(suffixIcon != null )?  suffixIcon: null,
                ),
              )
            ],
          ),
        )
    );

  }
  
}