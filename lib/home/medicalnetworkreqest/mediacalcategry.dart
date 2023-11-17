// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';
//
// import '../../core/logic/helpermethods.dart';
// import '../../core/widgets/bottom_navigationbar.dart';
// import 'cubit.dart';
// import 'medicalnetworkdetalis.dart';
// class MedicalCategoryScreen extends StatelessWidget {
//   const MedicalCategoryScreen ({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MedicalNetworkCubit()..getAllMedicalNetwork(),
//       child:Builder(builder: (context) {
//         MedicalNetworkCubit cubit = BlocProvider.of(context);
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child:  BlocConsumer(
//               bloc: cubit,
//               listener: (context, steate) {
//                 if (steate is SuccessMedicalNetworkStates) {}
//               },
//
//               builder: (context, steate) {
//                 if (steate is LoadingMedicalNetworkStates) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Container(
//                     margin: EdgeInsetsDirectional.only(top: MediaQuery.of(context).size.height*.01),
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.only(
//                                   start: MediaQuery.of(context).size.width*.03.toDouble()
//                               ),
//                               child: Text('medical network'.tr(),
//                                 style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.w700,
//                                     color: Theme.of(context).unselectedWidgetColor),
//                               ),
//                             ),
//
//                             Padding(
//                               padding: EdgeInsetsDirectional.only(
//                                   top: MediaQuery.of(context).size.width*.01,
//                                   end: MediaQuery.of(context).size.width*.04),
//                               child: GestureDetector(
//                                 onTap: (){
//                                   navigateTo(CustomNavBar());
//                                 },
//                                 child: Image.asset('assets/images/backicon.png',
//                                   width: MediaQuery.of(context).size.width*.09,
//                                   height: MediaQuery.of(context).size.height*.06, ),
//                               ),
//                             ),
//                           ],),
//                         SizedBox(height: 5,),
//                         Expanded(
//                           child: GridView.builder(
//                             physics: BouncingScrollPhysics(),
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (context, index) => Container(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Expanded(
//                                     flex: 4,
//                                     child: GestureDetector(
//                                       child: Container(
//                                         clipBehavior: Clip.antiAlias,
//                                         //padding: EdgeInsets.symmetric(horizontal: 24),
//                                         width: MediaQuery.of(context).size.width,
//                                         height:
//                                         MediaQuery.of(context).size.height *
//                                             .1,
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey.withOpacity(0.77),
//                                             borderRadius: const BorderRadius.vertical(
//                                               top: Radius.circular(20),
//                                             ),
//                                             image: DecorationImage(
//                                                 image: NetworkImage(
//                                                   cubit.medicalNetworkModel!
//                                                       .data[index].image,
//                                                 ),
//                                                 fit: BoxFit.cover)),
//                                       ),
//                                       onTap: (){
//
//                                         navigateTo(MedicalNetWorkDetailesScreen(
//                                           title: cubit.medicalNetworkModel!.data[index].category,
//                                           index:cubit.medicalNetworkModel!.data[index].id,image: cubit.medicalNetworkModel!.data[index].image,
//                                           hotLine:cubit.medicalNetworkModel!.data[index].hotLine ?? " ",
//                                           appoinments: cubit.medicalNetworkModel!.data[index].appointments ?? '',
//                                           discountPercentage: cubit.medicalNetworkModel!.data[index].discountPercentage ?? '',
//                                           address: cubit.medicalNetworkModel!.data[index].address ?? '',
//                                           governRate: cubit.medicalNetworkModel!.data[index].governorate ?? '',
//                                           region:  cubit.medicalNetworkModel!.data[index].region ?? '',) );
//                                       },
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.vertical(
//                                               bottom: Radius.circular(20)),
//                                           color: Theme.of(context)
//                                               .unselectedWidgetColor,
//                                         ),
//                                         width:
//                                         MediaQuery.of(context).size.width,
//                                         height:
//                                         MediaQuery.of(context).size.height *
//                                             .03,
//                                         child: Text(
//                                             cubit.categories![index],
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 color: Colors.white),
//                                             textAlign: TextAlign.center)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             itemCount: cubit.categories!.length,
//                             gridDelegate:
//                             SliverGridDelegateWithFixedCrossAxisCount(
//                               //SliverGridDelegateWithMaxCrossAxisExtent(
//                                 childAspectRatio: 6 / 5,
//                                 crossAxisSpacing:
//                                 MediaQuery.of(context).size.height *
//                                     .01,
//                                 mainAxisSpacing:
//                                 MediaQuery.of(context).size.width * .02,
//                                 //mainAxisExtent: 100,
//                                 crossAxisCount: 2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
