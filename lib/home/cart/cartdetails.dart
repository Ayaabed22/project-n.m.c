import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:n_m_c/home/cart/familycartscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/helpermethods.dart';
import '../../core/widgets/bottom_navigationbar.dart';
import '../../core/widgets/radio_button.dart';
import 'personcartdetails/cubit.dart';
import 'indivudalcartscreen.dart';



class CartDetalisScreen extends StatefulWidget {
  AddDataModel?  model;
  CartDetalisScreen({Key? key,this.model }) : super(key: key);

  @override
  State<CartDetalisScreen> createState() => _CartDetalisScreenState();
}

class _CartDetalisScreenState extends State<CartDetalisScreen> {
  bool steate = false;
  String? cardType='';
  int? cartPrice;


  @override
  Widget build(BuildContext context) {
    String individual = 'للفرد';
    String famliy = 'للاسره';

    return BlocProvider(
        create: (context) => CartCubit(),
        child: Builder(builder: (context) {

          return WillPopScope(
            onWillPop: () async {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:  (context) => CustomNavBar(),), (route) => false);
              return false;
            },
            child:Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: MediaQuery.of(context).size.height * .03,
                              start: MediaQuery.of(context).size.width * .06),
                          child: Text(
                            'applyforthemedicalcard'.tr(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(Theme.of(context)
                                    .primaryColor
                                    .value)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: MediaQuery.of(context).size.height*.03,
                              end: MediaQuery.of(context).size.width*.05),
                          child: GestureDetector(
                            onTap: (){
                              navigateTo(CustomNavBar());
                            },
                            child: Image.asset('assets/images/backicon.png',
                              width: MediaQuery.of(context).size.width*.09,
                              height: MediaQuery.of(context).size.height*.06, ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          radioText: famliy,
                          value: false,
                          cuurentValue: steate,
                          callBack: (value) {
                            setState(() {
                              steate = value!;
                              cardType==famliy;
                            });
                          },
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.20),
                          child: CustomRadioButton(
                            radioText: individual,
                            value: true,
                            cuurentValue: steate,
                            callBack: (value) {
                              setState(() {
                                steate = value!;
                                cardType=individual;


                              });
                            },
                          ),
                        ),


                      ],
                    ),
                    Expanded(
                      child: steate ? IndividualCartScreen(cardType:individual) : FamilyCartScreen(cardType:famliy),
                    )
                  ],
                ),
              )));


        }));
  }
}
