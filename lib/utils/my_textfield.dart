import 'package:flutter/material.dart';
import 'package:picsum_gallery/theme/app_colors.dart';

class MyTextfield extends StatelessWidget {
  final String textfieldtext;
  const MyTextfield({super.key,
  required this.textfieldtext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextField(
        decoration: InputDecoration(
          hintText: textfieldtext,
          hintStyle: TextStyle(
            color: grey,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none
        ),
      ),),
      Icon(Icons.search, color: grey,),
        ],
      ),);
  }
}