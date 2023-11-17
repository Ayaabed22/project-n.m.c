import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_m_c/home/pages/medical_network.dart';
import 'package:n_m_c/home/pages/profile.dart';
import '../../home/cart/customphotocart.dart';
import '../../home/view.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  List <String> titles=["home".tr(),"medical network".tr(),"medical cart".tr(),"profile".tr()];
  List <String> icons=["home","medicalnetwork","medicalcart","profile"];
  List <Widget> pages=[ HomeScreen(),MedicalNetworkPage(),CustomPhotoCartScreen(),ProfilePage()];
  int currentPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: Container(
        padding:EdgeInsetsDirectional.only(
        //   start: MediaQuery.of(context).size.width*.01
        // ,end: MediaQuery.of(context).size.height*.01,
        bottom: MediaQuery.of(context).size.height*.01),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    boxShadow: [
    BoxShadow(color: Color(0xffE6E6E6), spreadRadius: 0, blurRadius: 0.01,offset: Offset(0,1)),
    ],
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    bottomRight:Radius.circular(20.0) ,
        bottomLeft:Radius.circular(20.0)
    ),
    child: BottomNavigationBar(
          elevation:0.01,
          currentIndex: currentPage,
          onTap: (value){
            currentPage=value;
            setState(() {
            });
          },
          selectedLabelStyle: TextStyle(color: Color(Theme.of(context).unselectedWidgetColor.value)),
          unselectedLabelStyle:TextStyle(color:Color(0xff646464),) ,
          selectedItemColor: Color(Theme.of(context).unselectedWidgetColor.value)  ,
          unselectedItemColor:Color(0xff646464),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(Theme.of(context).cardColor.value),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: List.generate(titles.length, (index) => BottomNavigationBarItem(icon:Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.01),
              child: SvgPicture.asset("assets/images/${icons[index]}.svg",
                width: MediaQuery.of(context).size.width*.02,
                height: MediaQuery.of(context).size.height*.02,
                color:
                currentPage==index?Color(Theme.of(context).unselectedWidgetColor.value):Color(0xff646464),)),
              label: titles[index]),
          ),
        ),
      ),
    ));
  }
}