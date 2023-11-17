import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/logic/cache_helper.dart';
import 'package:n_m_c/home/imagegetreqests/states.dart';
import '../../core/logic/diohelper.dart';
import 'model.dart';

class ImagesCubit extends Cubit<ImagesStates> {
  ImagesCubit() :super(ImagesStates());
  ImageSliderModel imageSliderModel= ImageSliderModel();
  // List<Data> listOfSlider = [];


  images() async {
    emit(LoadingImagesStates());
    final response = await DioHelper.getData('slider',CashHelper.getToken());

    if (response.stauts == true) {
      imageSliderModel=ImageSliderModel.fromJson(response.response!.data);

      emit(SuccessImagesStates());
    } else {

      // ScaffoldMessenger.of().showSnackBar(SnackBar(content: Text(response.response!.data['status'])));
      emit((FailedImagesStates()));
    }
  }
}
