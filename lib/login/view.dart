import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:n_m_c/core/widgets/input.dart';
import 'package:n_m_c/login/cubit.dart';
import 'package:n_m_c/login/states.dart';

import '../signup/view.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> loginKey= GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
String? phone,password;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(
          builder: (context) {
            LoginCubit cubit = BlocProvider.of(context);
            return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                      child: Form(
                        key: loginKey,
                        child: (
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.01,
                                left: MediaQuery.of(context).size.width*.7,),
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(CustomNavBar());
                                Future.delayed(Duration(minutes:2),(){
                                 navigateTo(LoginScreen(),);

                                });
                              },
                              child: Text('loginvisitor'.tr(),style: TextStyle(fontWeight:FontWeight.w500 ,fontSize:16 ,
                              color:Color(Theme.of(context).unselectedWidgetColor
                              .value)),),
                            ),
            ),
            const SizedBox(height: 32,),
            Text('signup'.tr(),style: TextStyle(fontSize:32 ,fontWeight:FontWeight.w600 ,
            color: const Color(0xff1DA8E3).withAlpha(68),),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
             Text('Welcomelogin'.tr(),style: TextStyle(fontWeight:FontWeight.w300 ,fontSize:12 ,color: Color(0xff636363)),
            textAlign: TextAlign.center,),
            const SizedBox(height: 32,),

            Input(labelText: 'phonenumber'.tr(),controller: cubit.phoneController,
              onSaved: (value){
              phone=value;
            },validator:(value){
              if(value?.trim()=='' || value!.length>11){
                  return "Enter Vaild Data ";
              }
              else{
                  return null;
              }

            } ,),

            Input(labelText: 'password'.tr(),
              counterText: true,
              controller:cubit.passwordController,
              inputType: InputType.password,
              inputAction: TextInputAction.done,
           onSaved: (value){
              password=value;
           }
           ,validator: (value){
              if(value?.trim()=='' || value!.length<6){
                  return "Enter Vaild Data ";
              }
              else{
                  return null;
              }
            },),
            const SizedBox(height: 24,),
            BlocConsumer(
              bloc: cubit,
              listener: (context,state){
                  if(state is LoginSuccessState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
                    );
                    navigateTo(CustomNavBar(),isReplace: true);
                  }else if(state is LoginFiledState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('من فضلك قم بادخال البيانات صحيحة')),
                    );
                  }
            },
            builder: (context,state){
              if(state is LoginLoadingState){
            return const Center(child: CircularProgressIndicator(),);
            }else {
              return Btn(onPress: () {
                  CashHelper.setLogin(true);
                  CashHelper.setisnotFirstTime(true);
                  CashHelper.preferences.getBool('apply') ?? false;
                  if(loginKey.currentState!.validate()){
                    loginKey.currentState!.save();
                    cubit.login(context,phone!,password!);
                  }


            }, btnText: 'login'.tr(),);
            }

           // }
            // else {
            //     return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.data["msg"])));
            //
            //   }
            },),

            const SizedBox(height: 16,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text('do you have an account'.tr(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xffCBD1CE)),),
            GestureDetector(
                  onTap: (){
                    navigateTo(SignUpScreen(),);
                  },
                  child: Text('signup'.tr(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Color(Theme.of(context).unselectedWidgetColor.value)),)),
            ],)
            ]
            )
            ),
                      ),
            ),
                ),

            );
          }
      ),
    );
  }
}