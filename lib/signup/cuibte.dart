import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/signup/steates.dart';
import '../core/logic/diohelper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit():super(SignUpStates());
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  signUp(context) async {
    emit(SignUpLoadingState());
    try{
    final response = await DioHelper.sendData('auth/register',"",
      data: {
      "firstName": firstNameController.text,
        'LastName': lastNameController.text,
        'email': emailController.text,
        "phoneNumber": phoneController.text,
        "password": passwordController.text},
    );
    if (response.response?.data['status'] == true) {
      emit(SignUpSuccessState());
    } else {
      emit(SignUpFiledState());
    }
  }on DioException catch(e){
      emit(SignUpFiledState());
    }
  }
  }