import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/home/engagements/cubit.dart';
import 'package:n_m_c/home/engagements/steate.dart';
import 'package:n_m_c/home/imagegetreqests/states.dart';
import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';
import 'package:n_m_c/home/pages/searh.dart';
import 'package:n_m_c/home/servises/allservice.dart';
import 'package:n_m_c/home/servises/cubit.dart';
import 'package:n_m_c/home/servises/seate.dart';
import 'package:n_m_c/login/view.dart';
import '../core/logic/helpermethods.dart';
import '../core/widgets/bottom_navigationbar.dart';
import '../core/widgets/input.dart';
import 'engagements/allserviceview.dart';
import 'imagegetreqests/cubit.dart';
import 'medicalnetworkreqest/cubit.dart';
import 'medicalnetworkreqest/medicalnetworkdetalis.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentPage = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagesCubit()..images(),
        ),
        BlocProvider(
          create: (context) => MedicalNetworkCubit()..getLastMedicalNetwork(),
        ),
        BlocProvider(
          create: (context) => LastEngagementsCubit()..getlastEngagements(),
        ),
        BlocProvider(
          create: (context) => ServicesCubit()..getServices(),
        )
      ],
      child: Builder(builder: (context) {
        ImagesCubit imagesCubit = BlocProvider.of(context);
        MedicalNetworkCubit medicalNetworkCubit = BlocProvider.of(context);
        LastEngagementsCubit lastEngagementsCubit = BlocProvider.of(context);
        ServicesCubit servicesCubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top:MediaQuery.of(context).size.height*.01 ,
                        start: MediaQuery.of(context).size.width*.07),
                    child: Text(
                      "${'hello'.tr()}  ${CashHelper.getName()} ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).unselectedWidgetColor),
                    ),
                  ),
                  SizedBox(height: .00006,),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: MediaQuery.of(context).size.width*.07.toDouble()),
                    child: Text('how are you today'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffC9C9C9))),
                  ),
                  const SizedBox(
                    height:6,
                  ),

                  InkWell(
                    onTap:(){ navigateTo(SearchScreen(),);},
                    child: Input(
                      borderText: false,
                      labelText: 'search'.tr(),
                      iconPath: "assets/images/filtter.svg",
                      iconPrefix: true,
                      icon: true,
                      enabled: false,
                    ),
                  ),
                  SizedBox(height: 10,),
                  BlocConsumer<ImagesCubit, ImagesStates>(
                      listener: (context, state) {
                        if (state is SuccessImagesStates) {
                        }
                      }, builder: (context, state) {
                    if (state is LoadingImagesStates) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * .2,
                        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*.05),

                        child: PageView(
                          onPageChanged: (value) {
                            currentPage = value;
                            setState(() { });
                          },
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                            imagesCubit.imageSliderModel!.data!.length,
                                (index) => Container(
                              clipBehavior: Clip.antiAlias,
                              padding:EdgeInsetsDirectional.only
                                (
                                // start: MediaQuery.of(context).size.width*.0,
                                // end: MediaQuery.of(context).size.width*.03
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(16)),),

                              child: Image.network(
                                imagesCubit.imageSliderModel!.data![currentPage].imageUrl ?? '',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    // If there's no loading progress, the image is fully loaded.
                                    return child;
                                  } else {
                                    // If the image is still loading, you can display a loading indicator.
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.06),
                      child: Text(
                        'medical network'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff003C51)),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<MedicalNetworkCubit, MedicalNetworkStates>(
                      listener: (context, steate) {
                        if (steate is SuccessMedicalNetworkStates) {}
                      }, builder: (context, steate) {
                    if (steate is LoadingMedicalNetworkStates) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height*.2,
                       padding:  EdgeInsetsDirectional.only(start:MediaQuery.of(context).size.width*.06),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                 // padding:  EdgeInsetsDirectional.only(start:MediaQuery.of(context).size.height*.01),
                                  width: MediaQuery.of(context).size.width * .38,
                                  height: MediaQuery.of(context).size.height * .11,
                                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.77),
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20),),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            medicalNetworkCubit
                                                .medicalNetworkModel!
                                                .data[index]
                                                .image,),
                                          fit: BoxFit.cover)),
                                ),
                                onTap: (){
                                  navigateTo(MedicalNetWorkDetailesScreen(
                                    title:medicalNetworkCubit.medicalNetworkModel!.data![index].serviceProvider ??'',
                                    index:medicalNetworkCubit.medicalNetworkModel!.data![index].id,
                                    region:medicalNetworkCubit.medicalNetworkModel!.data![index].region??'',
                                    governRate: medicalNetworkCubit.medicalNetworkModel!.data![index].governorate??'',
                                    address:medicalNetworkCubit.medicalNetworkModel!.data![index].address??'',
                                    appoinments: medicalNetworkCubit.medicalNetworkModel!.data![index].appointments??'',
                                    hotLine:'${medicalNetworkCubit.medicalNetworkModel!.data![index].hotLine}' ,
                                    image: medicalNetworkCubit.medicalNetworkModel!.data![index].image ?? '',
                                    discountPercentage: medicalNetworkCubit.medicalNetworkModel!.data![index].discountPercentage??'',));
                                },
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(20)),
                                      color:
                                      const Color(0xff9185BE).withOpacity(0.77)),
                                  width: MediaQuery.of(context).size.width * .38,
                                  height: MediaQuery.of(context).size.height * .04,
                                  child: Text(
                                      medicalNetworkCubit.medicalNetworkModel!
                                          .data[index].category ??'',
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                      textAlign: TextAlign.center)),
                            ],
                          ),
                          itemCount: medicalNetworkCubit
                              .medicalNetworkModel!.data.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            //SliverGridDelegateWithMaxCrossAxisExtent(
                              childAspectRatio: 5 / 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              //mainAxisExtent: 100,
                              crossAxisCount: 1),
                        ),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 3,
                  ),
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
                            end: MediaQuery.of(context).size.width*0.05),
                        child: GestureDetector(
                          onTap: (){
                            navigateTo(AllServiveScreen());
                          },
                          child:Text("عرض المزيد",style: TextStyle(
                              fontSize: 14,fontWeight: FontWeight.w500),)),
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
                                          child: Image.network(
                                            lastEngagementsCubit
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
                                itemCount: lastEngagementsCubit
                                    .lastEngagementsModel!.data.length),
                          );
                        }
                      });
                    }
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: MediaQuery.of(context).size.width*.07),
                        child: Text(
                          'our service to improve medical institutions'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xff003C51)),
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: MediaQuery.of(context).size.width*0.05),
                      child: GestureDetector(
                          onTap: (){
                            navigateTo(AllSrevicesScreenView());
                          },
                          child:Text("عرض المزيد",style: TextStyle(
                              fontSize: 14,fontWeight: FontWeight.w400),)),
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
                                          servicesCubit.servicesModel!
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
                                      servicesCubit
                                          .servicesModel!.data[index].title,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                      textAlign: TextAlign.center)),
                            ],
                          ),
                          itemCount: servicesCubit.servicesModel!.data.length,
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}