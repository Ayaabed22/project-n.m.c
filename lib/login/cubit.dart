import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/logic/diohelper.dart';
import 'package:n_m_c/login/model.dart';
import 'package:n_m_c/login/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());

  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  login(context,String phone,String password) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.sendData(
        'auth/login', "",
        data: {
          "phoneNumber": phone,
          "password": password
        },
      );
      if (response.response?.data['status'] == true) {
        final model = UserData.fromJson(response.response?.data);
        CashHelper.saveLoginData(model);
        emit(LoginSuccessState());
      } else {
        emit(LoginFiledState());
      }
    } on DioException catch (e) {
      emit(LoginFiledState());

    }
  }
}
