import 'package:flutter/cupertino.dart';

import '../../main.dart';


GlobalKey<NavigatorState> navigate = GlobalKey<NavigatorState>();

void navigateTo (Widget page,{bool keepHistory=true,bool isReplace=false}) {
  if (isReplace) {
    Navigator.pushReplacement(navigate.currentContext!,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
          FadeTransition(opacity: animation
            , child: page,)
      ),
    );
  }
  else {
    Navigator.pushAndRemoveUntil(navigate.currentContext!, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ScaleTransition(
            scale: animation,
            child: page,),
    ), (route) => keepHistory);
  }
}