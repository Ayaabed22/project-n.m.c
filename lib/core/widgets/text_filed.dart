import 'package:flutter/material.dart';
class CustomTextFiled extends StatefulWidget {
  final TextEditingController? controller;
  bool colorEnabled, textType,isString;
  var keyboardType;
   String? text;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  bool? read;
  final void Function()? ontap;


   CustomTextFiled ({Key? key,
     this.validator,
     this.ontap,
     this.read=false,
     this.onSaved,
     this.controller,this.isString=true,this.colorEnabled=true,this.text='',this.keyboardType='',this.textType=false}) : super(key: key);

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {




  @override
  Widget build(BuildContext context) {
   return Padding(
     padding:
     EdgeInsetsDirectional.only(start:MediaQuery.of(context).size.width*.10,
         end: MediaQuery.of(context).size.width*.11),
     child: TextFormField(
          readOnly: widget.read as bool,
          onTap: widget.ontap,
          maxLines: 1,
          validator:widget.validator,
          autovalidateMode:AutovalidateMode.onUserInteraction,
          onSaved: widget.onSaved,
          controller:widget.controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.02),
            fillColor: Colors.white,
            filled: true,
            errorBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide( width: 3,color:Color(Theme.of(context).cardColor.value))),
            hintText:widget.text ,
            enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide( width: 3,color:Color(Theme.of(context).cardColor.value))),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide( width: 3,color:  widget.colorEnabled==true?Color(Theme.of(context).primaryColor.value):
      Color(Theme.of(context).unselectedWidgetColor.value),),),
          ),
          style: TextStyle(fontSize:18,fontWeight: FontWeight.w400),

          keyboardType:widget.textType?TextInputType.number:TextInputType.text,
        ),
   );
  }
}
