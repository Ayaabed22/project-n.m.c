import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
enum InputType{password,normal}
class Input extends StatefulWidget {
  final String labelText,iconPath;
  final double redis;
  final InputType inputType;
  final TextEditingController? controller;
  final bool icon,counterText,iconPrefix;
  final bool   enabled;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputAction inputAction;
  final bool borderText;
  final  Function(String?)? onChange;


Input ({Key? key,this.inputType=InputType.normal,this.inputAction=TextInputAction.next,required this.labelText,this.iconPath='',this.icon=false,this.counterText=false,
    this.controller,this.iconPrefix=false,this.redis=6.0,this.borderText=true,this.validator,this.onSaved,this.onChange,this.enabled=true}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input>{

  bool isPasswordShown=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.02,
          left: MediaQuery.of(context).size.width*.07,right:MediaQuery.of(context).size.width*.07 ),
      child: TextFormField(
        enabled:widget.enabled?true:false,
        textInputAction: widget.inputAction,
        obscureText: widget.inputType==InputType.password && isPasswordShown,
        validator:widget.validator,
        autovalidateMode:AutovalidateMode.onUserInteraction,
        controller:widget.controller,
         onSaved: widget.onSaved,
        style: TextStyle(fontSize:16,fontWeight: FontWeight.w400,color: Colors.black),
        decoration: InputDecoration(
      labelText: widget.labelText,
        labelStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 ,fontSize:15,),
        suffixIcon: widget.inputType== InputType.password?
        GestureDetector(onTap: (){
          isPasswordShown=!isPasswordShown;
          setState(() {
          });
        },child:isPasswordShown?SvgPicture.asset('assets/images/show.svg',fit: BoxFit.scaleDown,)
            :SvgPicture.asset('assets/images/unshow.svg',
        fit: BoxFit.scaleDown,)):widget.icon==true?
        SvgPicture.asset(widget.iconPath,fit: BoxFit.scaleDown,):null,
      prefixIcon:widget.iconPrefix==true?
      SvgPicture.asset('assets/images/searchicon.svg',fit:BoxFit.scaleDown,): null,
      counterText:widget.counterText==true?("forgot your password".tr()):null,
      counterStyle: TextStyle(fontSize: 16,color: Theme.of(context).unselectedWidgetColor),
      fillColor: Color(Theme.of(context).cardColor.value),
      filled: true,
      enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide( width: 3,color: Color(Theme.of(context).cardColor.value),),),
      border: widget.borderText?OutlineInputBorder(borderRadius: BorderRadius.circular(.8),
      borderSide: BorderSide( width: 3,color: Color(Theme.of(context).primaryColor.value),),)
        : OutlineInputBorder(
        borderSide: BorderSide(
        color: Color(Theme.of(context).cardColor.value), // Border color
          width: 1.0,          // Border width
        ),
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      // Other InputDecoration properties
    ),
        onChanged:widget.onChange,

      ),
    );
  }
}
