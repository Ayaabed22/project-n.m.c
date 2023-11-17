import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/home/cart/cartdetails.dart';
import 'package:n_m_c/home/cart/cubit.dart';
import 'package:n_m_c/home/cart/steate.dart';
import '../../core/widgets/btn.dart';
import '../../signup/view.dart';

class CustomPhotoCartScreen extends StatefulWidget {
  CustomPhotoCartScreen({Key? key}) : super(key: key);

  @override
  State<CustomPhotoCartScreen> createState() => _CustomPhotoCartScreenState();
}

class _CustomPhotoCartScreenState extends State<CustomPhotoCartScreen> {
  bool isCardFlipped = false;
  List<String> filteredImagesData = [];
  List<String> imagesFamilyMembers = [];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartInformationCubit>(context).getCartInformation(context);
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (cardKey.currentState != null) {
        cardKey.currentState!.toggleCard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      CartInformationCubit cubit = BlocProvider.of(context);
      return Scaffold(
          body: CashHelper.getPhone().isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * .9,

                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .09),
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      padding: EdgeInsetsDirectional.only(
                          top: MediaQuery.of(context).size.height * .01),
                      height: MediaQuery.of(context).size.height * .29,
                      child: Stack(
                        children: [
                          Positioned(
                              top: MediaQuery.of(context).size.height * .04,
                              left: MediaQuery.of(context).size.width * .04,
                              right: MediaQuery.of(context).size.width * .05,
                              child: Text(
                                'من فضلك قم بتسجيل الدخول فى الكارت الطبى',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(
                                        Theme.of(context).primaryColor.value)),
                              )),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .15,
                            left: MediaQuery.of(context).size.width * .01,
                            right: MediaQuery.of(context).size.width * .01,
                            child: Container(
                                child: Btn(
                              btnText: 'apply'.tr(),
                              onPress: () {
                                navigateTo(SignUpScreen(),keepHistory: false);
                              },
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: BlocConsumer<CartInformationCubit,
                          CartInformationStates>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is SuccessCartInformationStates) {
                          if (cubit.model!.card!.state == "الانتظار") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                    'الكارت قيد المراجعة في حاله الانتظار')));
                            navigateTo(CustomNavBar(),);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingCartInformationStates) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FailedCartInformationStates &&
                            cubit.errorCard.message == "الكارت غير موجود") {
                          return Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .33),
                            child: Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Container(
                                padding: EdgeInsetsDirectional.only(
                                    top: MediaQuery.of(context).size.height *
                                        .01),
                                height:
                                    MediaQuery.of(context).size.height * .29,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .05,
                                        child: Text(
                                          'قم بتسجيل الدخول فى الكارت الطبى',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color(Theme.of(context)
                                                  .primaryColor
                                                  .value)),
                                        )),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          .15,
                                      left: MediaQuery.of(context).size.width *
                                          .01,
                                      right: MediaQuery.of(context).size.width *
                                          .01,
                                      child: Container(
                                          child: Btn(
                                        btnText: 'apply'.tr(),
                                        onPress: () {
                                          navigateTo(CartDetalisScreen(),
                                              isReplace: true);
                                        },
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (cubit.model!.card!.state == 'تم الدفع' &&
                            cubit.model!.card!.cardType == 'للاسره') {
                          return SafeArea(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: MediaQuery.of(context).size.height * .01,
                                          start: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .04),
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
                                          top: MediaQuery.of(context).size.width*.01,
                                          end: MediaQuery.of(context).size.width*.04),
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
                                FlipCard(
                                  direction: FlipDirection.HORIZONTAL,
                                  key: cardKey,
                                  flipOnTouch: true,
                                  front: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top: MediaQuery.of(context).size.height * .03,
                                        start: MediaQuery.of(context).size.width * .04,
                                        end: MediaQuery.of(context).size.width * .04),
                                    height: MediaQuery.of(context).size.height * .75,
                                    child: Stack(children: [
                                      Image.asset(
                                        'assets/images/finalcartimage.png',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * .11,
                                          right: MediaQuery.of(context).size.width * .30,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(Theme.of(context).primaryColor.value), // Change this to the color you want
                                                width: 2.0, // Change the border width as needed
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width *.3,
                                            height: MediaQuery.of(context).size.height * .3,
                                            child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.network(
                                                  cubit.model!.card!.imageUrl ?? '',
                                                  width: MediaQuery.of(context).size.width * .1,
                                                  height: MediaQuery.of(context).size.height * .1,
                                                  fit: BoxFit.cover,
                                                )

                                                ),
                                          )),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * .36,
                                        right: MediaQuery.of(context).size.width * .34,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .3,
                                          child: Text(
                                            cubit.model!.card!.fullName ?? '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * .42,
                                        right: MediaQuery.of(context).size.width * .44,
                                        child: Text(
                                          cubit.model!.card!.id.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 30),
                                        ),
                                      ),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * .48,
                                        right: MediaQuery.of(context).size.width * .44,
                                        child: Text(cubit.model!.card!.created ?? '',
                                            style: TextStyle(fontSize: 20, color: Colors.white)),),
                                      Positioned(
                                        top:MediaQuery.of(context).size.height * .53,
                                        right:MediaQuery.of(context).size.width * .44,
                                        child: Text(
                                          cubit.model!.card!.deleted ?? '',
                                          style: TextStyle(fontSize: 20, color: Colors.white),),
                                      ),
                                    ]),
                                  ),
                                  back: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top: MediaQuery.of(context).size.height * .03,
                                        start: MediaQuery.of(context).size.width * .04,
                                        end: MediaQuery.of(context).size.width *.04),
                                    height: MediaQuery.of(context).size.height * .75,
                                    child:Stack(
                                  children: [
                                    Image.asset('assets/images/cardd.png',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.fill,
                                    ),
                                  Container(
                                    padding: EdgeInsetsDirectional.only(
                                    start: MediaQuery.of(context).size.width*.04,
                                        end:  MediaQuery.of(context).size.width*.04 ),

                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.height,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          top:MediaQuery.of(context).size.height*.05,
                                        start: MediaQuery.of(context).size.width*.04,
                                            end:  MediaQuery.of(context).size.width*.04 ),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Color(Theme.of(context).primaryColor.value), // Change this to the color you want
                                                        width: 2.0, // Change the border width as needed
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      child: Image.network(cubit.model!.familyMembers![0].imageUrl ??'',
                                                        height: MediaQuery.of(context).size.height*.15,
                                                        width: MediaQuery.of(context).size.width*.25,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      radius: 40,
                                                      backgroundColor: Colors.white,
                                                    ),
                                                  ),
                                                  Text(cubit.model!.familyMembers![0].name ?? '',
                                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,
                                                        color: Colors.white),),
                                                ],),
                                              Image.asset('assets/images/nmclogoimage.jpg',
                                                  height: MediaQuery.of(context).size.height*.15,
                                                  width: MediaQuery.of(context).size.width*.25,
                                                alignment: AlignmentDirectional.topEnd,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:  GridView(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2.5/2,
                                            // mainAxisSpacing: 4,
                                            // crossAxisSpacing: 6,

                                          ),
                                          children: List.generate( cubit.model!.familyMembers!.length,(index)=>
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Color(Theme.of(context).primaryColor.value), // Change this to the color you want
                                                        width: 2.0, // Change the border width as needed
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      child: Image.network(cubit.model!.familyMembers![index].imageUrl ??'',
                                                        height: MediaQuery.of(context).size.height*.15,
                                                        width: MediaQuery.of(context).size.width*.25,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      radius: 40,
                                                      backgroundColor: Colors.white,
                                                    ),
                                                  ),
                                                  Text(cubit.model!.familyMembers![index].name ?? '',
                                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,
                                                        color: Colors.white),),
                                                ],),
                                          ),
                                        )
                                        ,

                                      )
                                    ],
                                  ),
                                )


                                    ]),
                                ),
                                )],
                            ),
                          );
                        }

                        if (cubit.model!.card!.state == 'تم الدفع' &&
                            cubit.model!.card!.cardType == 'للفرد') {
                          return SafeArea(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: MediaQuery.of(context).size.height * .01,
                                          start: MediaQuery.of(context)
                                              .size
                                              .width *
                                              .04),
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
                                          top: MediaQuery.of(context).size.width*.01,
                                          end: MediaQuery.of(context).size.width*.04),
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
                                FlipCard(
                                  key: cardKey,
                                  flipOnTouch: true,
                                  direction: FlipDirection.HORIZONTAL,
                                  front: Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        start:
                                            MediaQuery.of(context).size.width *
                                                .04,
                                        end: MediaQuery.of(context).size.width *
                                            .04),
                                    height: MediaQuery.of(context).size.height *
                                        .75,
                                    child: Stack(children: [
                                      Image.asset(
                                        'assets/images/finalcartimage.png',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .11,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .30,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(Theme.of(context).primaryColor.value), // Change this to the color you want
                                                width: 2.0, // Change the border width as needed
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .3,
                                            child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.network(
                                                  cubit.model!.card!.imageUrl ??
                                                      '',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .1,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                  fit: BoxFit.cover,
                                                )
                                                //     : GridView.builder(
                                                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                //       childAspectRatio: 6 / 5,
                                                //       crossAxisSpacing: MediaQuery
                                                //           .of(context)
                                                //           .size
                                                //           .height * .01,
                                                //       mainAxisSpacing: MediaQuery
                                                //           .of(context)
                                                //           .size
                                                //           .width * .02,
                                                //       crossAxisCount: 2),
                                                //   itemBuilder: (BuildContext context,
                                                //       int index) =>
                                                //       Image.network(
                                                //         cubit.model?.familyMembers![index]
                                                //             .imageUrl ?? " ",
                                                //       ),
                                                //   itemCount: cubit.model?.familyMembers!.length,
                                                // ),
                                                ),
                                          )),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .36,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .34,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          child: Text(
                                            cubit.model!.card!.fullName ?? '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .42,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .44,
                                        child: Text(
                                          cubit.model!.card!.id.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .48,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .44,
                                        child: Text(
                                            cubit.model!.card!.created ?? '',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .53,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .44,
                                        child: Text(
                                          cubit.model!.card!.deleted ?? '',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  back:
                                      Image.asset('assets/images/cardflip.png'),
                                )
                              ],
                            ),
                          );
                        }

                        return SizedBox();
                      }),
                ));
    });
  }
}
