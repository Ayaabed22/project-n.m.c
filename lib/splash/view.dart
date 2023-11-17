import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/home/view.dart';
import 'package:n_m_c/login/view.dart';
import 'package:n_m_c/onboading/view.dart';
import '../core/logic/helpermethods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // @override
  // void initState()  {
  //   super.initState();
  //   Timer(Duration(seconds: 3),() async =>
  //       navigateTo(await CashHelper.getisnotFirstTime()?await CashHelper.getLogin()
  //           ?CustomNavBar():LoginScreen():OnBoardingScreen()
  //       )
  //
  //      //     ()=>Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) =>OnBoardingScreen(),
  //           );
  // }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future:Future.delayed(Duration(seconds: 3), () async{
          navigateTo(await CashHelper.getisnotFirstTime()?await CashHelper.getLogin()
              ?CustomNavBar():LoginScreen():OnBoardingScreen()
          );

    }),builder: (BuildContext context, AsyncSnapshot<Null> snapshot) {
      return Scaffold(
        body: Center(
          child: Flash(
            duration: Duration(seconds: 1),
            child: Image.asset("assets/images/splash.png",
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .08
              , width: MediaQuery
                  .of(context)
                  .size
                  .width * .66,),
          ),
        ),
      );
    });
    }
  }
