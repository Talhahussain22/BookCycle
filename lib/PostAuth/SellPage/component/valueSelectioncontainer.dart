import 'package:flutter/material.dart';

class ValueselectionContainer extends StatelessWidget {

  String text;
  bool IsSelected;
  VoidCallback onTap;

  ValueselectionContainer({super.key,required this.text,required this.IsSelected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 3),
        decoration: BoxDecoration(
          color: IsSelected? Colors.indigo.shade100:Color(0xFFEEEEEE),
          border: Border.all(color: IsSelected? Colors.blue.shade800:Colors.black54),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,style: TextStyle(color: Colors.black,fontWeight: IsSelected? FontWeight.w600:FontWeight.normal),),
      ),
    );
  }
}
