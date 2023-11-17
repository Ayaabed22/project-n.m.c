import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:n_m_c/core/widgets/input.dart';
import 'package:n_m_c/home/view.dart';
import 'package:n_m_c/login/view.dart';
import 'package:n_m_c/signup/steates.dart';
import '../core/logic/cache_helper.dart';
import '../core/logic/helpermethods.dart';
import 'cuibte.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> signupKey= GlobalKey<FormState>();

   SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpCubit(),
        child: Builder(
        builder: (context) {
      SignUpCubit cubit = BlocProvider.of(context);
      return Scaffold(
          body: SafeArea(
          child: SingleChildScrollView(
          child: Form(
            key: signupKey,
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.01,
          left: MediaQuery.of(context).size.width*.7,),
    child: GestureDetector(
      onTap: (){
        navigateTo(CustomNavBar());
      },
      child: Text(
      'loginvisitor'.tr(),
      style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color:
      Color(Theme.of(context).unselectedWidgetColor.value)),
      ),
    ),
    ),
    SizedBox(height: 25,),
    Text('create account'.tr(),style: TextStyle(fontSize:32 ,fontWeight:FontWeight.w600 ,
    color: Color(Theme.of(context).primaryColor.value),),textAlign: TextAlign.center,),
    SizedBox(height: 8,),
    Text('Welcomelogin'.tr(),style: TextStyle(fontWeight:FontWeight.w300 ,fontSize:12 ,color: Color(0xff636363)),
    textAlign: TextAlign.center,),
    SizedBox(height: 32,),
    Input(labelText: "firstname".tr(),controller:cubit.firstNameController,
       validator:(value){
          if(value?.trim()=='' || value!.length<2){
            return "Enter Vaild Data ";
          }


        }
    ),
    Input(labelText: "lastname".tr(),controller: cubit.lastNameController,
        validator:(value){
          if(value?.trim()=='' || value!.length<2){
            return "Enter Vaild Data ";
          }


        }),
    Input(labelText: "phonenumber".tr(),controller: cubit.phoneController,
        validator:(value){
          if(value?.trim()=='' || value!.length>11){
            return "Enter Vaild Data ";
          }

        }
    ),
    Input(labelText: "email".tr(),controller: cubit.emailController,
        validator:(value){
          if(value?.trim()=='' || value!.length<2){
            return "Enter Vaild Data ";
          }


        }),
    Input(
        icon: true,
        inputType: InputType.password,
        iconPath: 'assets/icons/password.png',
        labelText: "password".tr(),controller: cubit.passwordController,
       validator:(value){
          if(value?.trim()=='' || value!.length<6){
            return "Enter Vaild Data ";
          }


        }
    ),
    BlocConsumer(
    bloc: cubit,
    listener: (context,state){
    if(state is SignUpSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجل الدخول بنجاح')),
      );
    navigateTo(LoginScreen(),);
    }else if(state is SignUpFiledState){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك قم بادخال البيانات')),
      );
    }
    },
    builder: (context,state) {
      if (state is SignUpLoadingState) {
        return Center(child: CircularProgressIndicator(),);
      } else {
        return Btn(onPress: () {
          CashHelper.setLogin(true);
          CashHelper.setisnotFirstTime(true);
          if(signupKey.currentState!.validate()){
            cubit.signUp(context);

          }

        }, btnText: 'signup'.tr(),
        );
      }
    },
    ),
    SizedBox(height: 16,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('do you have an account?'.tr(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xffCBD1CE)),),
    GestureDetector(
        onTap: (){
            navigateTo( LoginScreen(),);
        },
        child: Text('login'.tr(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Color(Theme.of(context).unselectedWidgetColor.value)),)),
   // ],)
   ],
    ),
    ],),
          ),
    ),
    )
      );
    }
    ),
    );
    }
  }
