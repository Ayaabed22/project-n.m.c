import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/servises/seate.dart';
import '../../core/logic/helpermethods.dart';
import '../../core/widgets/bottom_navigationbar.dart';
import 'cubit.dart';
class AllSrevicesScreenView extends StatelessWidget {
  const AllSrevicesScreenView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => ServicesCubit()..getAllServices(),
        child: Builder(
        builder: (context) {
      ServicesCubit cubit = BlocProvider.of(context);
    return Scaffold(
     body:SafeArea(
       child:Column(children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
                 padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.05,
                     top: MediaQuery.of(context).size.height*.02),
                 child: Text(
                   'our service to improve medical institutions'.tr(),
                   style: TextStyle(
                       fontWeight: FontWeight.w700,
                       fontSize: 16,
                       color: Color(0xff003C51)),
                 )),
             Padding(
               padding: EdgeInsetsDirectional.only(
                   end: MediaQuery.of(context).size.width*0.05,
                   top: MediaQuery.of(context).size.height*.02),
               child: GestureDetector(
                   onTap: (){
                     navigateTo(CustomNavBar());
                   },
                   child:Image.asset('assets/images/backicon.png',width: 20,height: 20,)),
             )
           ],
         ),

         const SizedBox(
           height: 16,
         ),
         BlocConsumer<ServicesCubit, ServicesStates>(
             listener: (context, steate) {
               if (steate is SuccessServicesStates) {}
             }, builder: (context, steate) {
           if (steate is LoadingServicesStates) {
             return const Center(
               child: CircularProgressIndicator(),
             );
           } else {
             return Container(
               height: MediaQuery.of(context).size.height * .15,
               margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
               child: GridView.builder(
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, index) => Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Container(
                       clipBehavior: Clip.antiAlias,
                       padding:  EdgeInsets.symmetric(
                         horizontal: MediaQuery.of(context).size.width*.04,
                       ),
                       width: MediaQuery.of(context).size.width * .4,
                       height: MediaQuery.of(context).size.height * .1,
                       decoration: BoxDecoration(
                           color: Colors.pink,
                           borderRadius: const BorderRadius.vertical(
                             top: Radius.circular(20),
                           ),
                           image: DecorationImage(
                               image: NetworkImage(
                                 cubit.servicesModel!
                                     .data[index].imageUrl,
                               ),
                               fit: BoxFit.cover)),
                     ),
                     Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.vertical(
                               bottom: Radius.circular(20)),
                           color:
                           Theme.of(context).unselectedWidgetColor,
                         ),
                         width: MediaQuery.of(context).size.width * .4,
                         height:
                         MediaQuery.of(context).size.height * .03,
                         child: Text(
                             cubit
                                 .servicesModel!.data[index].title,
                             style: const TextStyle(
                                 fontSize: 10, color: Colors.white),
                             textAlign: TextAlign.center)),
                   ],
                 ),
                 itemCount: cubit.servicesModel!.data.length,
                 gridDelegate:
                 const SliverGridDelegateWithFixedCrossAxisCount(
                   //SliverGridDelegateWithMaxCrossAxisExtent(
                     childAspectRatio: 5 / 5,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10,
                     //mainAxisExtent: 100,
                     crossAxisCount: 1),
               ),
             );
           }
         }),
       ],)

     ),

    );
  }
    ));
  }
}
