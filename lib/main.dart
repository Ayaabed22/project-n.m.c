import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/splash/view.dart';
import 'core/design/colors.dart';
import 'home/cart/cartdata/cubit.dart';
import 'home/cart/cubit.dart';
import 'home/cart/paymentMethod/cubit.dart';
import 'home/medicalnetworkreqest/cubitcategory.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CashHelper.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartInformationCubit(),),
        BlocProvider(create: (context) => MedicalNetworkCategoryCubit(),),
        BlocProvider(create: (context)=> PaymentCubit()),
        BlocProvider(
          create: (context) => CartDataCubit(),
        ),
      ],

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
              fontFamily: "Cairo",
              primarySwatch: getMaterialColor(primaryColor.value),
              unselectedWidgetColor: Color(0xff9185BE),
              cardColor: Color(0xffF9FAFA),
              canvasColor: Color(0xffA4AEBB),
              scaffoldBackgroundColor: Colors.white),
          navigatorKey: navigate,
          // builder: (BuildContext context, child) {
          //   return Overlay(
          //     initialEntries: [
          //       OverlayEntry(
          //         builder: (BuildContext context) => SafeArea(
          //           child: Scaffold(
          //            // body: child,
          //             bottomNavigationBar: CustomNavBar(),
          //           ),
          //         ),
          //       ),
          //     ],
          //   );
          // },
          home:SplashScreen(),

          //Routing stuff like generate route & navigator key
        ));

  }
}

