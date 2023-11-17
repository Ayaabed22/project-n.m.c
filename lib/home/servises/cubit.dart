
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/servises/model.dart';
import 'package:n_m_c/home/servises/seate.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/diohelper.dart';

class ServicesCubit extends Cubit<ServicesStates> {
  ServicesCubit() :super(ServicesStates());
  ServicesModel? servicesModel;

  getServices() async {
    emit(LoadingServicesStates());
    final response = await DioHelper.getData('lastServices',CashHelper.getToken());
    if (response.stauts == true) {
      servicesModel = ServicesModel.fromJson(response.response!.data);
      emit(SuccessServicesStates());
    } else {

      emit((FailedServicesStates()));
    }
  }

  getAllServices() async {
    emit(LoadingServicesStates());
    final response = await DioHelper.getData('service',CashHelper.getToken());
    if (response.stauts == true) {
      servicesModel = ServicesModel.fromJson(response.response!.data);
      emit(SuccessServicesStates());
    } else {

      emit((FailedServicesStates()));
    }
  }
}