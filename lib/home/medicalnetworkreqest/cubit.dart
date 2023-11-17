import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/medicalnetworkreqest/model.dart';
import 'package:n_m_c/home/medicalnetworkreqest/statescategroy.dart';

import 'package:n_m_c/home/medicalnetworkreqest/steate.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/diohelper.dart';
import 'medicalcategory.dart';
import 'modeldata.dart';

class MedicalNetworkCubit extends Cubit<MedicalNetworkStates> {
  MedicalNetworkCubit() : super(MedicalNetworkStates());
  MedicalNetwokModel? medicalNetworkModel;
  MedicalData? model;
  late List<String>? categories=[];
  List<String> images = [];
  late List<String>? governorates = [];
  late List<String>? specializations = [];
  late List<String>? regions = [];
  late List<Map <String,dynamic>> storage=[];
  MedicalCategory medicalCategory=MedicalCategory();

  getLastMedicalNetwork() async {
    emit(LoadingMedicalNetworkStates());
    final response = await DioHelper.getData('lastmedicalNetwork', CashHelper.getToken());
    if (response.stauts == true) {
      medicalNetworkModel = MedicalNetwokModel.fromJson(response.response!.data);
      emit(SuccessMedicalNetworkStates());
    } else {
      emit((FiledMedicalNetworkStates()));
    }
  }
  getAllMedicalNetwork() async {

    emit(LoadingMedicalNetworkStates());
    final response =
    await DioHelper.getData('medicalNetwork', CashHelper.getToken());
    if (response.stauts == true) {
      medicalNetworkModel = MedicalNetwokModel.fromJson(response.response!.data);
      emit(SuccessMedicalNetworkStates());

      for (var item in medicalNetworkModel!.data) {

        if (!categories!.contains(item.category)) {
          categories!.add(item.category);

        }
        if (!governorates!.contains(item.governorate)) {
          governorates!.add(item.governorate);

        }
        if (!regions!.contains(item.region)) {
          regions!.add(item.region);

        }

      }

    } else {
      emit((FiledMedicalNetworkStates()));
    }
  }
  getMedicalByCategory() async {

    emit(LoadingMedicalNetworkStates());
    final response =
    await DioHelper.getData('getCategoryProductCounts', CashHelper.getToken());
    if (response.stauts == true) {
      medicalCategory = MedicalCategory.fromJson(response.response!.data);
      for(var item in medicalCategory.data ?? []){

      }
      emit(SuccessMedicalNetworkStates());


    } else {
      emit((FiledMedicalNetworkStates()));
    }
  }


}