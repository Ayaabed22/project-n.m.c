import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/widgets/input.dart';
import 'package:n_m_c/home/pages/medical_network.dart';
import '../../core/logic/helpermethods.dart';
import '../medicalnetworkreqest/cubitcategory.dart';
import '../medicalnetworkreqest/medicalnetworkdetalis.dart';
import '../medicalnetworkreqest/modeldata.dart';
import '../medicalnetworkreqest/statescategroy.dart';


class MedicalNetWorkScreen extends StatefulWidget {

  String?title;

  MedicalNetWorkScreen({
    Key? key,
    required this.title,
  }) : super(key: key);



  @override
  State<MedicalNetWorkScreen> createState() => _MedicalNetWorkScreenState();

}



class _MedicalNetWorkScreenState extends State<MedicalNetWorkScreen> {

 @override
  void initState() {
    super.initState();
    // log('test');

    BlocProvider.of<MedicalNetworkCategoryCubit>(context)
        .getAllMedical(widget.title ?? 'لا يوجد اسم');
    // BlocProvider.of<MedicalNetworkCategoryCubit>(context).getServiceCategory();
  }


  @override
  Widget build(BuildContext context) {
    MedicalNetworkCategoryCubit cubit = BlocProvider.of(context);

    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<MedicalNetworkCategoryCubit,
              MedicalNetworkCtegoryStates>(
        bloc: cubit,
        listener: (context, steate) {
          if (steate is SucessMedicalNetworkCtegoryStates) {}
        },
        builder: (context, steate) {
          if (steate is LoadingMedicalNetworkCtegoryStates) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: EdgeInsetsDirectional.only(
                  top: MediaQuery.of(context).size.height * .01),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: MediaQuery.of(context).size.width *
                                .03.toDouble()),
                        child: Text(
                          'medical network'.tr(),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).size.width * .01,
                            end: MediaQuery.of(context).size.width * .04),
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(MedicalNetworkPage());
                          },
                          child: Image.asset(
                            'assets/images/backicon.png',
                            width: MediaQuery.of(context).size.width * .09,
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  /*SizedBox(
                    height: 200,
                    width: 200,
                    child: TextFormField(
                        cursorColor:
                        Theme.of(context).colorScheme.primary,
                        decoration: const InputDecoration(
                          hintText: 'Find a character...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary,
                            fontSize: 18),
                        onChanged: (value){
                          cubit.getSearchedServices(value);
                        }),
                  ),*/
                  Input(
                    labelText: 'search'.tr(),
                    iconPath: "assets/images/filter.svg",
                    iconPrefix: true,
                    onChange: (string) {
                      setState(() {
                        cubit.getSearchedServices(string!);
                      });

                      /* setState(() {
                           cubit.flitterData=cubit.modelMedical.date!.where((element) {

                             if(element.serviceProvider!.toLowerCase().isEmpty) {
                               cubit.modelMedical!.date!.length;
                             }
                             else if(element.serviceProvider!.toLowerCase().contains(string!.toLowerCase())) {
                               cubit.flitterData.length;
                             }
                             return cubit.flitterData.length;
                           }).toList();

                           // cubit.flitterData.contains(string!.toLowerCase());
                         });*/
                    },
                  ),
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
                                      MediaQuery.of(context).size.height * .1,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.77),
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            cubit.data[index].image ?? '',
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                onTap: () {
                                  navigateTo(MedicalNetWorkDetailesScreen(
                                    title: cubit.data![index]
                                            .serviceProvider ??
                                        '',
                                    index: cubit.data![index].id,
                                    region: cubit.data[index]
                                            .region ??
                                        '',
                                    governRate: cubit.data[index]
                                            .governorate ??
                                        '',
                                    address: cubit.data[index]
                                            .address ??
                                        '',
                                    appoinments: cubit.data![index]
                                            .appointments ??
                                        '',
                                    hotLine:
                                        '${cubit.data[index].phoneNumber}',
                                    image:
                                        cubit.data![index].image ??
                                            '',
                                    discountPercentage: cubit.data![index].discountPercentage ??
                                        '',
                                  ));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20)),
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .03,
                                  child: Text(
                                      cubit.data[index].serviceProvider ?? '',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                      textAlign: TextAlign.center)),
                            ),
                          ],
                        ),
                      ),
                      itemCount: cubit.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 6 / 5,
                          crossAxisSpacing:
                              MediaQuery.of(context).size.height * .01,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width * .02,
                          crossAxisCount: 2),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
