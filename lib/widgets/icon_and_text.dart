

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndText extends StatelessWidget {

  final IconData icon;
  final String text;

  final Color iconColor;



  const IconAndText({ Key? key, 
    required this.icon,
    required this.iconColor,
    required this.text 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color:iconColor,size:Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text)
      ],
    );
  }
}