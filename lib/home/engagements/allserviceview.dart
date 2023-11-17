import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/home/engagements/steate.dart';

import '../../core/logic/helpermethods.dart';
import 'cubit.dart';
class AllServiveScreen extends StatelessWidget {
  const AllServiveScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastEngagementsCubit()..getAllEngagements(),
      child: Builder(
        builder: (context) {
          LastEngagementsCubit cubit = BlocProvider.of(context);
          return Scaffold(

          body:SafeArea(
            child:Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: MediaQuery.of(context).size.width * .07),
                        child: Text(
                          'our engagements'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xff003C51)),
                        )
                    ),
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

                  ]),


              const SizedBox(
                height: 4,
              ),
              BlocConsumer<LastEngagementsCubit, LastEngagementsStates>(
                  listener: (context, steate) {
                    if (steate is SuccessLastEngagementsStates) {}
                  }, builder: (context, steate) {
                if (steate is LoadingLastEngagementsStates) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return BlocConsumer<LastEngagementsCubit,
                      LastEngagementsStates>(listener: (context, steate) {
                    if (steate is SuccessLastEngagementsStates) {}
                  }, builder: (context, steate) {
                    if (steate is LoadingLastEngagementsStates) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
                        height: MediaQuery.of(context).size.height * .15,
                        width: double.infinity,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              width: MediaQuery.of(context).size.width*.30,
                              height:MediaQuery.of(context).size.height*.15 ,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Theme.of(context)
                                    .unselectedWidgetColor,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*.29,
                                  height: MediaQuery.of(context).size.height*.13,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(2.0),
                                    child: ClipOval(
                                      child: Image.network(cubit
                                          .lastEngagementsModel!
                                          .data[index]
                                          .imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 3,
                            ),
                            itemCount: cubit
                                .lastEngagementsModel!.data.length),
                      );
                    }
                  });
                }
              }),
            ],)

          ),
          );

        })
    );
  }
}
