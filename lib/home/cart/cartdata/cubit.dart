import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/home/cart/cartdata/steates.dart';
import '../indivudalcartscreen.dart';
import 'model.dart';

class CartDataCubit extends Cubit<SendDataCartSteates> {
  CartDataCubit() : super(SendDataCartSteates());
  String? cardKey;
  CartModelData? dataCart=CartModelData();
  PersonDataCart? personDataCart=PersonDataCart();
  String? model;
  String? expiredDate;

  Future<Object?> sendInformationCartData(
    AddDataModel userData,
    String type,
    int paymentId,
  ) async {
    try {
      emit(LoadingSendDataCartSteates());
      final response =
          await Dio().post('https://api.nmc.com.eg/public/api/executePayment',
              options: Options(
                headers: {
                  'Accept': 'application/json',
                },
              ),
              data: {
            "first_name": userData.fullName!.text.split("")[0],
            "last_name": userData.fullName!.text,
            "email": userData.emailController!.text,
            "phone": CashHelper.getPhone(),
            "address": userData.addressController!.text,
            "card_type": type,
            "price": type == "للاسرة" ? 500 : 300,
            "payment_method_id": paymentId,
            "cartTotal": type == 'للاسرة' ? 500 : 300,
          });
      if (response.statusCode == 200) {
        personDataCart = PersonDataCart.fromJson(response.data);

        if (personDataCart?.data?.cartModelData?.paymentDataModel?.fawryCode?.isNotEmpty ?? false) {
          model = personDataCart!.data!.cartModelData.paymentDataModel!.fawryCode ?? '';
          print("model is");
          print(model);
        }
        if (personDataCart?.data?.cartModelData?.paymentDataModel?.expireDate?.isNotEmpty ?? false) {
          expiredDate = personDataCart!.data!.cartModelData.paymentDataModel!.expireDate ?? '';
          print("expire date is");
          print(expiredDate);

        }
       else if(personDataCart?.data?.cartModelData?.paymentDataModel?.amanCode?.toString().isNotEmpty ?? false) {
          model = personDataCart!.data!.cartModelData.paymentDataModel!.amanCode.toString() ?? '';

        }

         else if(personDataCart?.data?.cartModelData?.paymentDataModel?.masaryCode?.toString().isNotEmpty ?? false) {
          model = personDataCart!.data!.cartModelData.paymentDataModel!.masaryCode.toString() ?? "";

        }
         else if(
        personDataCart?.data?.cartModelData?.paymentDataModel?.mezaReference?.toString().isNotEmpty ?? false) {
          model = personDataCart!.data!.cartModelData.paymentDataModel!.mezaReference.toString() ?? '';


        }
          if( personDataCart?.data?.cartModelData?.paymentDataModel?.redirectTo?.isNotEmpty ?? false) {
           model = personDataCart?.data?.cartModelData?.paymentDataModel?.redirectTo ?? '';

         }
        cardKey = personDataCart?.data?.cartModelData.invoiceKey ?? '';


        emit(SuccessSendDataCartSteates());



      } else {

        emit(FailedSendDataCartSteates());
      }
    } on DioException catch (e) {

      emit(FailedSendDataCartSteates());
    }
  }
}
