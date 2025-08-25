import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Color buttoncolor;
  VoidCallback onTap;
  Widget child;
  double? height;
  double? width;
  double borderRadius;
  Color? bordercolor;
  CustomButton({super.key,required this.buttoncolor,required this.onTap,required this.child,this.height=50,this.width=double.maxFinite,this.borderRadius=15,this.bordercolor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: bordercolor??Colors.transparent),
          color: buttoncolor
        ),
        child: child,
      ),
    );
  }
}
