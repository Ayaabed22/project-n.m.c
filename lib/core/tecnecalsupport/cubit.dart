import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/core/tecnecalsupport/steates.dart';

class TecnecalSupportCubit extends Cubit<TecnecalSupportStates> {
  TecnecalSupportCubit() :super(TecnecalSupportStates());
  final message = TextEditingController();

  sendMessage() async {
    if(message.text.isEmpty){
      emit(TecnecalFiledState());
    }
    emit(TecnecalLoadingState());

    try{
    final response = await Dio().post(
      'https://api.nmc.com.eg/public/api/sendMessage',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
      data:{
    'Name':[CashHelper.getName(),CashHelper.getLastName()].join(),
    'PhoneNumber':CashHelper.getPhone(),
    'Email':CashHelper.getEmail(),
    'TheMessage':message.text,
    },
    );
    if (response.statusCode==201) {
      emit(TecnecalSuccessState());
    }
    else if (response.statusCode==400){
      emit(TecnecalFiledState());
    }
  }on DioException catch(e){
      emit(TecnecalFiledState());

    }
    }
  }

