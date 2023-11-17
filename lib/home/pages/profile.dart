import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/helpermethods.dart';
import 'package:n_m_c/profile/webview.dart';
import '../../core/tecnecalsupport/cubit.dart';
import '../../core/tecnecalsupport/steates.dart';
import '../../core/widgets/bottom_navigationbar.dart';
import '../../core/widgets/input.dart';
import '../../profile/editprofile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => TecnecalSupportCubit(),
      child: Builder(builder: (context) {
        TecnecalSupportCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/profile.png',),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .02,
                      left: MediaQuery.of(context).size.width * .03 ,
                      child: GestureDetector(
                        onTap: (){
                          navigateTo(CustomNavBar(),keepHistory: false);
                        },
                        child: Image.asset(
                          'assets/images/backicon.png',
                          width: MediaQuery.of(context).size.width*.07,
                          height: MediaQuery.of(context).size.height*.07,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .14,
                      child: CircleAvatar(
                        foregroundColor: Colors.black,
                        radius: 40,
                        child: Image.asset(
                          'assets/images/photopic.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  "${CashHelper.getName()}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Theme.of(context).unselectedWidgetColor),
                )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .01),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff000040).withOpacity(.025),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: GestureDetector(
                          onTap: () async {
                            navigateTo(
                              EditProfileScreen(),
                            );
                          },
                          child: Text('edit profile'.tr(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        minLeadingWidth:
                            MediaQuery.of(context).size.width * .01,
                        visualDensity: VisualDensity.comfortable,
                        leading: Image.asset(
                          'assets/icons/edit.png',
                          width: MediaQuery.of(context).size.width * .1,
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                      ),
                      SizedBox(
                        height: .2,
                      ),
                      // ListTile(
                      //   title: GestureDetector(
                      //     onTap: () {
                      //       navigateTo(
                      //         WebViewScreen(url: 'https://youtube.com'),
                      //       );
                      //     },
                      //     child: Text('privacy'.tr(),
                      //         style: TextStyle(
                      //             color:
                      //                 Theme.of(context).unselectedWidgetColor,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500)),
                      //   ),
                      //   minLeadingWidth:
                      //       MediaQuery.of(context).size.width * .01,
                      //   visualDensity: VisualDensity.comfortable,
                      //   leading: Image.asset(
                      //     'assets/icons/privacy.png',
                      //     width: MediaQuery.of(context).size.width * .1,
                      //     height: MediaQuery.of(context).size.height * .1,
                      //   ),
                      // ),
                      // SizedBox(height: .2,
                      // ),
                      ListTile(
                        title: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => AlertDialog(
                                    title: Column(
                                      children: [
                                        Transform.translate(offset:Offset (0,-30),
                                            child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor:  Color(Theme.of(context).unselectedWidgetColor.value),
                                                child: Image.asset('assets/images/message.png',
                                                  width: MediaQuery.of(context).size.width*.11,
                                                  color:Colors.white,
                                                  alignment: Alignment.center,
                                                  height:MediaQuery.of(context).size.height*.05 ,))),

                                        Container(
                                          child: TextFormField(
                                              controller: cubit.message,
                                              decoration: InputDecoration(hintText: "type message".tr(),
                                                fillColor: Color(Theme.of(context).cardColor.value),
                                                filled: true,
                                                enabledBorder:
                                                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0),
                                                  borderSide: BorderSide(
                                                    width: 3, color: Color(Theme.of(context).cardColor.value),
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(.6), borderSide: BorderSide(width: 3,
                                                  color: Color(Theme.of(context).unselectedWidgetColor.value),),
                                                ),
                                              ),
                                              textAlign: TextAlign.right,
                                              maxLines: 3),
                                          margin: EdgeInsetsDirectional.only(
                                              start: MediaQuery.of(context).size.width*.01,
                                              end: MediaQuery.of(context).size.width*.01,
                                              //  top: MediaQuery.of(context).size.height*.01,
                                              bottom: MediaQuery.of(context).size.height*.01),
                                          color: Color(Theme.of(context).cardColor.value),
                                        ),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                    titlePadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.03),
                                    actions: [
                                      BlocConsumer(
                                          bloc: cubit,
                                          listener: (context, state) {
                                            if (state
                                            is TecnecalSuccessState) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'تم ارسال الرسالة بنجاح ')));
                                            } else if (state
                                            is TecnecalFiledState) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'من فضلك ادخل البيانات ')));
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state
                                            is TecnecalLoadingState) {
                                              return const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              );
                                            } else
                                              return Container(
                                                padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.03),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    cubit.sendMessage();
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: Text('save'.tr()),
                                                ),
                                                width: MediaQuery.of(context).size.width * 20,
                                                // padding: EdgeInsets.symmetric(horizontal: 10)
                                              );
                                          }),
                                    ])
                            );
                          },
                          child: Text('technical support'.tr(),
                              style: TextStyle(
                                  color:
                                  Theme.of(context).unselectedWidgetColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)
                          ),

                        ),
                        minLeadingWidth:
                            MediaQuery.of(context).size.width * .01,
                        visualDensity: VisualDensity.comfortable,
                        leading: Image.asset(
                          'assets/icons/user.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      SizedBox(
                        height: .2,
                      ),
                      // ListTile(
                      // title: Text('delete account'.tr(),
                      // style: TextStyle(
                      // color: Theme
                      //     .of(context)
                      //     .unselectedWidgetColor,
                      // fontSize: 16,
                      // fontWeight: FontWeight.w500)),
                      // minLeadingWidth: MediaQuery
                      //     .of(context)
                      //     .size
                      //     .width * .01,
                      // visualDensity: VisualDensity.comfortable,
                      // leading: Image.asset(
                      // 'assets/icons/delete.png',
                      // width: 24,
                      // height: 24,
                      // ),
                      // ),
                      // SizedBox(
                      // height: .2,
                      // ),
                      ListTile(
                        title: GestureDetector(
                          onTap: () {
                            CashHelper.logout(context);
                          },
                          child: Text('logout'.tr(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        minLeadingWidth:
                            MediaQuery.of(context).size.width * .01,
                        visualDensity: VisualDensity.comfortable,
                        leading: Image.asset(
                          'assets/icons/logout.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    ));
  }
}
