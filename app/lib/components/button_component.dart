import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget{
  final String label;
  final Color textColor;
  final Color backgroundColor;

  const ButtonComponent({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:  BorderRadius.circular(100)
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }


}