import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_m_c/login/view.dart';
import 'package:n_m_c/onboading/model.dart';

import '../core/logic/helpermethods.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  List<OnBoardingDataModel>model=
  [OnBoardingDataModel(image:"assets/images/onboarding1.png" , description: "it is one of the hospitals that is distinguished by the presence of elite doctors and consultants.it is one of the hospitals that is distinguished by the presence of elite doctors and consultants".tr()),
  OnBoardingDataModel(image: "assets/images/onboarding2.png", description: "it is one of the hospitals that is distinguished by the presence of elite doctors and consultants.it is one of the hospitals that is distinguished by the presence of elite doctors and consultants".tr()),
  OnBoardingDataModel(image: "assets/images/onboarding3.png",description: "it is one of the hospitals that is distinguished by the presence of elite doctors and consultants.it is one of the hospitals that is distinguished by the presence of elite doctors and consultants".tr())];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(top: MediaQuery.of(context).size.height*.01,
                      start: MediaQuery.of(context).size.width*.1),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(LoginScreen());
                    },
                    child: Text(
                      'skip'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 95,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.38,
                  child: PageView(
                    onPageChanged: (value) {
                      currentPage = value;
                      setState(() {});
                    },
                    physics: BouncingScrollPhysics(),
                    children: List.generate(
                      3,
                      (index) => Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1,),
                          child: Image.asset(
                            model[currentPage].image,
                            height: MediaQuery.of(context).size.height*.44,
                            width:MediaQuery.of(context).size.width*.44 ,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: index == 2 ? 0 : MediaQuery.of(context).size.width*.01),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(
                              index == currentPage ? 0xff00B0EB : 0xffD9D9D9),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffE8F8FD),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32.0),
                        topLeft: Radius.circular(32.0),
                      )),
                  width: MediaQuery.of(context).size.width*.44,
                  height: MediaQuery.of(context).size.height*.33,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: MediaQuery.of(context).size.height*.02,
                        end: MediaQuery.of(context).size.width*.04, start: MediaQuery.of(context).size.width*.05),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'hello'.tr(),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff00B0EB)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            model[currentPage].description,
                            //textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffCCCCCC)),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (currentPage == 0 || currentPage == 1) {
                                currentPage = currentPage + 1;
                                model[currentPage];
                                setState(() {});
                              } else {
                                navigateTo(LoginScreen(),);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.7),
                              child: CircleAvatar(
                                child: SvgPicture.asset(
                                  'assets/images/arrowicon.svg',
                                  width: MediaQuery.of(context).size.width*.03,
                                  height: MediaQuery.of(context).size.height*.03,
                                ),
                                radius: 24,
                                backgroundColor: Color(0xff00B0EB),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
