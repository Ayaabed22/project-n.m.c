import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/medicalnetworkreqest/statescategroy.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/diohelper.dart';
import 'medicalcategory.dart';
import 'modeldata.dart';

class MedicalNetworkCategoryCubit extends Cubit<MedicalNetworkCtegoryStates> {
  MedicalNetworkCategoryCubit() : super(MedicalNetworkCtegoryStates());
  MedicalCategory medicalCategory = MedicalCategory();
  List<MedicalNetworkData> searchResult = [];
  MedicalDataNetWorkCategory modelMedical = MedicalDataNetWorkCategory();
  List<MedicalNetworkData> data = [];

  getAllMedical(String ctegoryName) async {
    data = [];
    emit(LoadingMedicalNetworkCtegoryStates());
    //log('data');
    final response = await DioHelper.getData(
        'getMedicalNetworkByCategory/${ctegoryName}', CashHelper.getToken());
    if (response.stutesCode == 200) {
      // log('response${response.response!.data}');
      modelMedical =
          MedicalDataNetWorkCategory.fromJson(response.response!.data);
      data = modelMedical.date!;
      emit(SucessMedicalNetworkCtegoryStates());
    } else {
      emit(FiledMedicalNetworkCtegoryStates());
    }
  }


  void getSearchedServices(String searchedCharacter,)async {

    try{

      emit(LoadingMedicalNetworkCtegoryStates());
      searchResult = modelMedical.date!.where((service) {
        return service.serviceProvider!.contains(searchedCharacter);
        //  .startsWith(searchedCharacter);
      }).toList();
      data = searchResult.isEmpty ? modelMedical.date! : searchResult;


      emit(SucessMedicalNetworkCtegoryStates());
    }catch (e){
      emit(FiledMedicalNetworkCtegoryStates());
    }
  }

  // void getServiceCategory() async {
  //   data = [];
  //   try {
  //     emit(LoadingMedicalNetworkCtegoryStates());

  //     data = modelMedical.date!;

  //     emit(SucessMedicalNetworkCtegoryStates());
  //   } catch (e) {
  //     emit(FiledMedicalNetworkCtegoryStates());
  //   }
  // }
}


