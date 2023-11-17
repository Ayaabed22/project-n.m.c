import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  dynamic value,cuurentValue;
  String radioText;
  Function(dynamic) callBack;
  CustomRadioButton ({Key? key,this.radioText='',required this.value,required this.callBack,required this.cuurentValue}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*.4,
      child:Theme(
      data: Theme.of(context).copyWith(
      listTileTheme: ListTileThemeData(
      horizontalTitleGap: 2,//here adjust based on your need
      )
      ),child: RadioListTile(
            value:widget.value,
            dense: true,
            groupValue: widget.cuurentValue,
          title: Text(widget.radioText, style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(Theme.of(context).unselectedWidgetColor.value)),),
          onChanged:widget.callBack,


        ),
      ),
    );

  }

  }



// return SizedBox(
// width: 150,
// child: RadioListTile(
// value:widget.value,
// groupValue: widget.cuurentValue,
// title: Text(widget.radioText, style: TextStyle(fontSize: 12, color: Colors.black),),
// onChanged:widget.callBack,
//
//
// ),
// );