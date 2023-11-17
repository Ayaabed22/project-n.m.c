import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/home/cart/paymentMethod/steates.dart';
import 'model.dart';

class PaymentCubit extends Cubit<PaymentMethodSteates> {
  PaymentCubit() :super(PaymentMethodSteates());
  PaymentModel? paymentModel;
  PaymentData payment=PaymentData();
  int? selectdItem;
  int? index;
  String? redirect;


  getPaymentMethods() async {
    try {
      emit(LoadingPaymentMethodSteates());
      final response = await Dio().get(
        'https://api.nmc.com.eg/public/api/paymentMethods',
        options: Options(
          headers: {
            "Token": "Bearer ${CashHelper.getToken()}",
            'Accept': 'application/json',
          },
        ),
      );
      paymentModel=PaymentModel.fromJson(response.data);

      emit(SuccessPaymentMethodSteates());


    } on DioException catch (e) {
      emit(FailedPaymentMethodSteates());

    }
  }
}
