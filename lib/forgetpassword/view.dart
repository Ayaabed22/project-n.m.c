import 'package:flutter/material.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:n_m_c/core/widgets/input.dart';
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
               Padding(
                 padding: const EdgeInsets.only(top: 25,left: 300,right: 29),
                 child: Image.asset("assets/icons/close.png",width:14,height:14,color:Theme.of(context).unselectedWidgetColor,),
               ),
              SizedBox(height: 28,),
              Text('نسيت كلمه المرور',style: TextStyle(fontSize:32 ,fontWeight:FontWeight.w600 ,
                color: Color(Theme.of(context).primaryColor.value),),textAlign: TextAlign.center,),
              SizedBox(height: 8,),
              Text('مرحبا بك من فضلك قم بادخال البريد الالكتروني',style: TextStyle(fontWeight:FontWeight.w300 ,fontSize:12 ,color: Color(0xff636363)),
                textAlign: TextAlign.center,),
              SizedBox(height: 32,),
              Input(labelText: "البريد الالكتروني"),
              Btn(btnText: 'استرجاع كلمة المرور',onPress: (){},)

            ],

          ),
        ),
      ),
    );
  }
}
