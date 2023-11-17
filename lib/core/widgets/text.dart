import 'package:flutter/material.dart';
class TextWiddget extends StatefulWidget {
  String lableText;
  bool textColor,textdirection,isPadding;

  TextWiddget ({Key? key,required this.lableText,this.textColor=true,this.textdirection=true,this.isPadding=true}) : super(key: key);

  @override
  State<TextWiddget> createState() => _TextWiddgetState();
}

class _TextWiddgetState extends State<TextWiddget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child:
        Padding(
          padding:EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.11),
          child: Text(widget.lableText,style:
          TextStyle(fontSize:16 ,fontWeight: FontWeight.w600,
            color:widget.textColor==true?Color(0xff20384B):Color(Theme.of(context).unselectedWidgetColor.value),),



          ),
        ),
        )
      ],

    );
  }
}
