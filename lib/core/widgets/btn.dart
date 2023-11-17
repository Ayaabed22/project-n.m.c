import 'package:flutter/material.dart';
class Btn extends StatelessWidget {
  final String btnText;
  //final String inputType;
  final VoidCallback onPress;
  final bool isPassword;

   Btn ({Key? key,required this.btnText,required this.onPress,this.isPassword=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
      child: ElevatedButton(onPressed: (){
        FocusManager.instance.primaryFocus?.unfocus();

      if (onPress != null) {
        onPress!();
      }

      },style: ElevatedButton.styleFrom(side: BorderSide(color: Color(Theme.of(context).primaryColor.value),
      ),fixedSize:Size(MediaQuery.of(context).size.width*.999,MediaQuery.of(context).size.height*.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),),),
        child: Text(btnText,
          style: TextStyle(fontSize:20 ,fontWeight:FontWeight.w500 ,color:Color(0xffFFFFFF)),),
      ),
    );
  }
}
