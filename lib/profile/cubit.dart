import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/profile/steates.dart';
import '../core/logic/cache_helper.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileStates());
  final emailController = TextEditingController(text: CashHelper.getEmail());
  final phoneController = TextEditingController(text: CashHelper.getPhone());
  final fullNameController = TextEditingController(text: [CashHelper.getName(), CashHelper.getLastName()].join(' '),);
  final passwordController = TextEditingController();

  Future editProfile(context) async {
    emit(LoadingEditProfileStates());
    try {
      final response = await Dio().post(
        'https://api.nmc.com.eg/public/api/auth/edite-profile',
        options: Options(headers: {
          "Authorization": "Bearer ${CashHelper.getToken()}",
          'Accept': 'application/json',
          //'Content-Type': 'application/json'
        }),
        data: {
          'email': emailController.text,
          "phoneNumber": phoneController.text,
          "firstName": fullNameController.text.split(' ')[0],
          'LastName': fullNameController.text.split(' ')[1],
          'password':passwordController.text
        },
      );


      if (response.statusCode == 200) {
        CashHelper.preferences.setString('firstName', fullNameController.text.split('')[0]);
        CashHelper.preferences.setString('LastName', fullNameController.text.split('')[1]);
        CashHelper.preferences.setString('phoneNumber', phoneController.text);
        CashHelper.preferences.setString('email', emailController.text);
        CashHelper.preferences.setString('password', passwordController.text);

        emit(SuccessEditProfileStates());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          final errorData = e.response!.data;
          if (errorData != null &&
              errorData is Map &&
              errorData.containsKey('message')) {
            final errorMessage = errorData['message'];
          }
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('لم يتم تغيير البيانات')));
        emit(FailedEditProfileStates());
      }
    }
  }
}
