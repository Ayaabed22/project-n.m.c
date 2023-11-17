import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:n_m_c/home/pages/profile.dart';
import 'package:n_m_c/profile/cubit.dart';
import 'package:n_m_c/profile/steates.dart';
import '../core/logic/helpermethods.dart';
import '../core/widgets/bottom_navigationbar.dart';
import '../core/widgets/text.dart';
import '../core/widgets/text_filed.dart';


class EditProfileScreen extends StatelessWidget {

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditProfileCubit(),
        child: Builder(
          builder: (context) {
            EditProfileCubit cubit = BlocProvider.of(context);

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*.2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .02,
                            left: MediaQuery.of(context).size.width * .03 ,
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(ProfilePage(),keepHistory: false);
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
                            top: MediaQuery.of(context).size.height*.14,
                            child: CircleAvatar(
                              radius: 40,
                              child: Image.asset(
                                'assets/images/photopic.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top:  MediaQuery.of(context).size.height*.20,
                            right:  MediaQuery.of(context).size.width*.40,
                            child: CircleAvatar(
                              radius: 15,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  size: 17,
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      Padding(
                          padding:EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.09),
                          child: TextWiddget(lableText:"name".tr(), textColor: false,isPadding: false)),
                      SizedBox(height: 6),
                      CustomTextFiled(
                      colorEnabled: false,
                      //text: [CashHelper.getName(),CashHelper.getLastName()].join(' '),
                      controller:cubit.fullNameController,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width*.04),
                        child: TextWiddget(
                          isPadding: false,
                          lableText: "email".tr(),
                          textColor: false,
                        ),
                      ),
                      SizedBox(height: 6),
                      CustomTextFiled(
                      colorEnabled: false,
                      controller: cubit.emailController,
                      ),
                      SizedBox(height: 10),
                      TextWiddget(lableText: "phonenumber".tr(), textColor: false,isPadding: false,),
                      SizedBox(height: 6),
                      CustomTextFiled(
                      colorEnabled: false,
                      controller: cubit.phoneController,
                      ),
                      TextWiddget(lableText: "password".tr(), textColor: false,isPadding: false),
                      SizedBox(height: 6),
                      CustomTextFiled(
                        colorEnabled: false,
                        controller: cubit.passwordController,
                      ),
                      SizedBox(height: 32),

                      BlocConsumer(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is SuccessEditProfileStates) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" تم تحديث الدانا بنجاح")));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoadingEditProfileStates) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Btn(
                              btnText: 'save'.tr(),
                              onPress: () {
                                cubit.editProfile(context);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
