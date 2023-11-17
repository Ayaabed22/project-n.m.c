import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/widgets/bottom_navigationbar.dart';
import 'package:n_m_c/home/cart/personcartdetails/steats.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/logic/helpermethods.dart';
import '../../../core/widgets/btn.dart';
import '../cartdata/cubit.dart';
import '../cartdata/model.dart';
import '../cartdetails.dart';
import '../familycartscreen.dart';
import '../indivudalcartscreen.dart';
import '../paymentMethod/cubit.dart';
import 'modelmassage.dart';


class CartCubit extends Cubit<CartStates> {

  PaymentCubit paymentCubit = BlocProvider.of<PaymentCubit>(
      navigate.currentContext!);
  final cartDataCubit = BlocProvider.of<CartDataCubit>(
      navigate.currentContext!);
  ModelMessage model = ModelMessage();

  CartCubit() : super(CartStates());

  Future sendData(context,
      List <PersonModelData>? familyMembers, AddDataModel userData,
      String invoice, String type,
      {File? image}) async {
    Map<String, dynamic> data = {};
    data.addAll({
      'image': MultipartFile.fromFileSync(
        FamilyCartScreen.imagePersonCard.path,
        filename: FamilyCartScreen.imagePersonCard.path
            .split("/")
            .last,),
      //      MultipartFile.fromFileSync(
      //   image!.path,
      //   filename: image.path.split("/").last,
      // ),
      "invoices_key": invoice,
      "full_name": userData.fullName?.text ?? " ",
      "address": userData.addressController?.text ?? " ",
      "date_of_birth": userData.dateOfBirthController?.text,
      "national_id": userData.nationalIdController?.text ?? " ",
      "phone_number": CashHelper.getPhone(),
      "job": userData.jobController?.text ?? " ",
      "card_type": type,
      "home_phone": userData.homePhoneController?.text ?? " ",
      "company_name": userData.companyNameController?.text ?? " ",
      "email": userData.emailController?.text ?? " ",
      "work_location": userData.workLocationController?.text ?? " "
    });

    if (familyMembers!.isNotEmpty) {
      for (var i = 0; i < familyMembers.length; i++) {
        data.addAll({
          "family_members[$i][name]": familyMembers[i].nameController?.text ??
              " ",
          "family_members[$i][age]": int.parse(
              familyMembers[i].ageController!.text),
          "family_members[$i][national_id]": familyMembers[i]
              .nationalIdController?.text ?? " ",
          "family_members[$i][gender]": familyMembers[i].gender ?? " ",
          "family_members[$i][image]": MultipartFile.fromFileSync(
            familyMembers[i].imageProfil.path,
            filename: familyMembers[i].imageProfil.path
                .split("/")
                .last,
          ),
        });
      }
    }

    try {
      final response =
      await Dio().post('https://api.nmc.com.eg/public/api/bookings',
          options: Options(
            headers: {
              'Accept': 'application/json',
              "async": true,
              "crossDomain": true,
            },
          ),
          data: FormData.fromMap(data));


      if (response.statusCode == 201) {
        ModelMessage model = ModelMessage.fromJson(response.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم ارسال البيانات بنجاح')));


        emit(SuccessCartStates());

      }


      else if (response.statusCode == 422) {
        emit(FailedCartStates());
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ قم بتسجيل الدخول مرة اخرى')));

    }
  }

  Future<void> _lunchUrl(String url)async {
    final Uri uri=Uri.parse(url);
    if(! await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    ));
  }
  Future<void> getpaymentway(context) async {
    if (paymentCubit.selectdItem == 3) {
      //daliog
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text('كود الدفع: ', style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
                Text(cartDataCubit.model!, style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
              ],
            ),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Text('تاريخ الانتهاء: ', style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),),
                  Text(cartDataCubit.expiredDate!, style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );


    }
    if (paymentCubit.selectdItem == 4) {
      //daliog
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' كود الدفع:', style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
                Text(cartDataCubit.model!, style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    if (paymentCubit.selectdItem == 12)  {
      //daliog
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' كود الدفع: ', style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
                Text(cartDataCubit.model!, style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (paymentCubit.selectdItem == 14)  {
      //daliog
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text(' كود الدفع: ', style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
                Text(cartDataCubit.model!, style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (paymentCubit.selectdItem == 11 ) {
      _lunchUrl(cartDataCubit.model!);
    }
    if (paymentCubit.selectdItem == 2 )  {
      _lunchUrl(cartDataCubit.model!);
    }
  }
}
