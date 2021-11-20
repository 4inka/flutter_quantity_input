import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color? buttonColor, iconColor;
  final Function onTap;

  const IconButtonWidget({
    required this.icon,
    this.buttonColor,
    this.iconColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          icon,
          size: 25,
          color: iconColor ?? Colors.white
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: buttonColor ?? Theme.of(context).primaryColor,
        ),
        width: 38,
        height: 38
      ),
      onTap: () => onTap()
    );
  }
}