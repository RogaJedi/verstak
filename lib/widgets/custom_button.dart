import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double padding;
  final Function() onTap;
  final Color splashColor;
  final Color highlightColor;
  final Color mainColor;
  final bool extraShadow;
  final double width;
  final double height;
  final String text;
  final Color textColor;
  final double fontSize;
  final bool hasIcon;
  final Icon? icon;

  const CustomButton({
    super.key,
    required this.padding,
    required this.onTap,
    required this.splashColor,
    required this.highlightColor,
    required this.mainColor,
    required this.extraShadow,
    required this.width,
    required this.height,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.hasIcon,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Ink(
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
                extraShadow ?
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ) :
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, 0),
                )
              ]
          ),
          width: width,
          height: height,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hasIcon
                    ? icon!
                    : SizedBox.shrink(),
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}