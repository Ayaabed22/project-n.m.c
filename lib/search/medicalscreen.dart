import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/home/medicalnetworkreqest/cubit.dart';
import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';

import '../home/medicalnetworkreqest/medicalnetworkdetalis.dart';


class MedicalScreen extends StatefulWidget {
  List<Map<String,dynamic>>store;
  MedicalScreen({Key? key,required this.store}) : super(key: key);
  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (context) => MedicalNetworkCubit()..getAllMedicalNetwork(),
      child: Builder(builder: (context) {
        MedicalNetworkCubit cubit = BlocProvider.of(context);
       return Scaffold(
          backgroundColor: Colors.white,
          body:widget.store.isEmpty?Center(child: Text("هذة البيانات غير متوفرة",style: TextStyle(
            fontSize: 30,fontWeight: FontWeight.w600,color:Color(Theme.of(context).primaryColor.value)
          ),
          ),):SafeArea(
            child :BlocConsumer(
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
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Row(children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.04.toDouble()),
                            child: Text('medical network'.tr(),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).unselectedWidgetColor),
                            ),
                          ),
                          SizedBox(width: 130,),
                          Image.asset('assets/images/cart.jpg',width: MediaQuery.of(context).size.width*.09,
                            height: MediaQuery.of(context).size.height*.06, ),
                        ],),
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
                                                 widget.store[index]['image']
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      onTap: (){

                                        navigateTo(MedicalNetWorkDetailesScreen(
                                          title: widget.store[index]['category'] ?? '' ,
                                          index:widget.store[index]['id'] ?? ' ',
                                          image:  widget.store[index]['image'],
                                          hotLine: widget.store[index]['hotLine'] ?? " ",
                                          appoinments:  widget.store[index]['appointments']?? '',
                                          discountPercentage:  widget.store[index]['discountPercentage'] ?? '',
                                          address: widget.store[index]['address'] ?? '',
                                          governRate: widget.store[index]['governorate'] ?? " ",
                                          region:   widget.store[index]['region'],),isReplace: true);
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
                                        child: Text(
                                            widget.store[index]['category'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                            textAlign: TextAlign.center)),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: widget.store.length,
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
            )),
       );
      }),
    );
  }
}
