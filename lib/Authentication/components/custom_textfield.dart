import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintext;
  TextEditingController controller;
  String? Function(String?)? validator;
  int maxlinex;
  bool isreadOnly=false;
  Color color=Color(0xFF393E46);
  Color borderColor=Color(0x8AFFFFFF);
  Color? generalboderColor;
  Color hintextcolor;
  Color textColor;
  double borderRadius;
  double horizontalpadding;
  double verticalpadding;
  VoidCallback? onTap;
  Function(String)? onchanged;



  CustomTextField({super.key,this.onTap,required this.hintext,required this.controller,required this.validator,this.maxlinex=1,this.isreadOnly=false,required this.color,required this.borderColor,required this.hintextcolor,required this.textColor,this.borderRadius=15,this.horizontalpadding=15,this.verticalpadding=15,this.generalboderColor,this.onchanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxlinex,
      readOnly: isreadOnly,
      onTap: onTap,
      onChanged: onchanged,
      onTapOutside: (event){
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(color: textColor),
      decoration: InputDecoration(

        filled: true,
        fillColor: color,
        contentPadding: EdgeInsets.symmetric(horizontal: horizontalpadding,vertical:verticalpadding),
        hintText: hintext,
        hintStyle: TextStyle(color: hintextcolor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: generalboderColor==null? Colors.black:generalboderColor!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color:borderColor)
        )
      ),
    );
  }
}
