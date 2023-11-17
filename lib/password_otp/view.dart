import 'package:flutter/material.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class OtpScreen extends StatelessWidget {
  const OtpScreen ({Key? key}) : super(key: key);

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
              Text('تم ارسال كود التفعيل المكون من 5 ارقام فى رسالة قصيرة على البريد الالكتروني',style: TextStyle(fontWeight:FontWeight.w300 ,fontSize:10 ,color: Color(0xff636363)),
                textAlign: TextAlign.center,),
              SizedBox(height: 12,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: PinCodeTextField(
                  showCursor: true,
                  appContext: context,
                  length: 5,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    selectedColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).cardColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(6),
                    fieldHeight: 64,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                  ),
                  cursorHeight: 3.3,
                  cursorWidth: 3.3,
                  cursorColor: Theme.of(context).primaryColor,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  onCompleted: (value){},
                ),
              ),
              SizedBox(height: 24,),
              Btn(btnText: 'استرجاع كلمة المرور',onPress: (){},),
              SizedBox(height: 16,),
              Text('اعادة ارسال الكود',style: TextStyle(fontWeight: FontWeight.w700,
                  fontSize: 16,color: Theme.of(context).unselectedWidgetColor),
              textAlign: TextAlign.center,)

            ],
          ),
        ),
      ),
    );
  }
}
