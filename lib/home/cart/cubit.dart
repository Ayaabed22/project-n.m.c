import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/home/cart/cartdetails.dart';
import 'package:n_m_c/home/cart/personcartdetails/modeinfomationcard.dart';
import 'package:n_m_c/home/cart/steate.dart';
import '../../core/logic/helpermethods.dart';
import '../../core/widgets/bottom_navigationbar.dart';
import 'model.dart';

class CartInformationCubit extends Cubit<CartInformationStates> {
  CartInformationCubit() : super(CartInformationStates());
  CardInformation? model = CardInformation();
  CardInformationData errorCard=CardInformationData();
  List<String>? familyMember =[];
  List<String>? familyName=[];

  getCartInformation(context) async {
    emit(LoadingCartInformationStates());
    try {
      final String phone = CashHelper.getPhone();

      final response = await Dio().get(
        'https://api.nmc.com.eg/public/api/show/$phone',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        model = CardInformation.fromJson(response.data);

        if(model!.familyMembers!.isNotEmpty){
          for(var item in model!.familyMembers!){
            familyMember!.add(item.imageUrl ?? '');
            familyName!.add(item.name ?? '');
          }
        }


        emit(SuccessCartInformationStates());
      }
      else {
        emit(FailedCartInformationStates());
      }


    } on DioException catch (e) {
      errorCard=CardInformationData.fromJson(e.response!.data);

     if ( errorCard.message=="الكارت غير موجود"){


    emit(FailedCartInformationStates());
    }
     else{
       emit(FailedCartInformationStates());
    }
  }
}}
