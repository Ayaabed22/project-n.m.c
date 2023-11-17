import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/home/medicalnetworkreqest/cubit.dart';
import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';
import '../medicalnetworkreqest/medicalnetworkdetalis.dart';
import 'medical.dart';
class MedicalNetworkPage extends StatelessWidget {

   MedicalNetworkPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalNetworkCubit()..getMedicalByCategory(),
      child:Builder(builder: (context) {
        MedicalNetworkCubit cubit = BlocProvider.of(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:  BlocConsumer(
              bloc: cubit,
              listener: (context, steate) {
                if (steate is SuccessMedicalNetworkStates) {}
              },

              builder: (context, steate) {
                if (steate is LoadingMedicalNetworkStates) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    margin: EdgeInsetsDirectional.only(top: MediaQuery.of(context).size.height*.01),
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
                                navigateTo(CustomNavBar(),isReplace: true);
                              },
                              child: Image.asset('assets/images/backicon.png',
                                width: MediaQuery.of(context).size.width*.09,
                                height: MediaQuery.of(context).size.height*.06, ),
                            ),
                          ),
                        ],),
                        SizedBox(height: 5,),
                        Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        //padding: EdgeInsets.symmetric(horizontal: 24),
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.77),
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://nmc.com.eg/Admin/public/images/${cubit.medicalCategory.data![index].image ?? '' }',
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      onTap: (){
                                        log('navigate :${cubit.medicalCategory.data![index].category}');
                                        navigateTo(
                                            MedicalNetWorkScreen(
                                          title:cubit.medicalCategory.data![index].category,)
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(20)),
                                          color: Theme.of(context)
                                              .unselectedWidgetColor,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        child: Text('${cubit.medicalCategory.data![index].category??''} ${cubit.medicalCategory.data![index].MedicalNetwork.toString()??''}',

                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                            textAlign: TextAlign.center)),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: cubit.medicalCategory.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    //SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 6 / 5,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.height *
                                            .01,
                                    mainAxisSpacing:
                                        MediaQuery.of(context).size.width * .02,
                                    //mainAxisExtent: 100,
                                    crossAxisCount: 2),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}






