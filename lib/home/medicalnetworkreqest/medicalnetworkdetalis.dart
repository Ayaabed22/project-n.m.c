import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_m_c/home/pages/medical_network.dart';
import 'package:n_m_c/search/medicalscreen.dart';

import '../../core/logic/helpermethods.dart';
import '../../core/widgets/bottom_navigationbar.dart';

class MedicalNetWorkDetailesScreen extends StatefulWidget {
  int? index;
  String? title,
      image,
      hotLine,
      appoinments,
      discountPercentage,
      address,
      governRate,
      region;

  MedicalNetWorkDetailesScreen(
      {Key? key,
      required this.index,
      required this.image,
      required this.title,
      required this.hotLine,
      required this.appoinments,
      required this.discountPercentage,
      required this.address,
      required this.governRate,
      required this.region})
      : super(key: key);

  @override
  State<MedicalNetWorkDetailesScreen> createState() =>
      _MedicalNetWorkDetailesScreenState();
}



List names = ['homeiconsvg', 'locationiconsvg', 'stariconsvg', 'phoneiconsvg', 'discounticonsvg', 'timeiconsvg'];

class _MedicalNetWorkDetailesScreenState
    extends State<MedicalNetWorkDetailesScreen> {
  @override
  Widget build(BuildContext context) {
    List nameText = [
      '${widget.region} ${widget.governRate}',
      widget.address,
      widget.title,
      widget.hotLine,
      widget.discountPercentage,
      widget.appoinments
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: MediaQuery.of(context).size.width * .05,
              end: MediaQuery.of(context).size.width * .05,
              top: MediaQuery.of(context).size.height * .01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: MediaQuery.of(context).size.width*.03.toDouble()
                      ),
                      child: Text('medical network'.tr(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).unselectedWidgetColor),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: MediaQuery.of(context).size.width*.01,
                          end: MediaQuery.of(context).size.width*.04),
                      child: GestureDetector(
                        onTap: (){
                          navigateTo(CustomNavBar());
                        },
                        child: Image.asset('assets/images/backicon.png',
                          color: Color(Theme.of(context).unselectedWidgetColor.value),
                          width: MediaQuery.of(context).size.width*.09,
                          height: MediaQuery.of(context).size.height*.06, ),
                      ),
                    ),
                  ],),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .900,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                        bottom: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.image!),
                        fit: BoxFit.cover,
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.02),
                        child: Text(
                        widget.title!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: MediaQuery.of(context).size.height*.01,),
                SizedBox(
                  height: 15,
                ),
                Container(
                    // height: MediaQuery.of(context).size.height * .40,
                    //  width: MediaQuery.of(context).size.width * .900,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                          bottom: Radius.circular(15),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff00B0EB).withOpacity(.25),
                            Color(0xff9185BE).withOpacity(.55)
                          ],
                        )),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: nameText.map((item) {

                          int index = nameText.indexOf(item);
                          if (item == " ") {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  .00000000000000000000000000001,
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: MediaQuery.of(context).size.height * .01,
                                  bottom:
                                      MediaQuery.of(context).size.height * .01,
                                  start: MediaQuery.of(context).size.width * .03),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/${names[index]}.svg'
                                     ,fit: BoxFit.scaleDown,),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }).toList()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
