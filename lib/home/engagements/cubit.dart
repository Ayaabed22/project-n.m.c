import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/engagements/steate.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/diohelper.dart';
import 'model.dart';

class LastEngagementsCubit extends Cubit<LastEngagementsStates> {
  LastEngagementsCubit() :super(LastEngagementsStates());
  LastEngagementsModel? lastEngagementsModel;

  getlastEngagements() async {
    emit(LoadingLastEngagementsStates());
    final response = await DioHelper.getData('lastEngagements',CashHelper.getToken());
    if (response.stauts == true) {
      lastEngagementsModel = LastEngagementsModel.fromJson(response.response!.data);
      emit(SuccessLastEngagementsStates());
    } else {

      emit((FailedLastEngagementStates()));
    }
  }

  getAllEngagements() async {
    emit(LoadingLastEngagementsStates());
    final response = await DioHelper.getData('allEngagements',CashHelper.getToken());
    if (response.stauts == true) {
      lastEngagementsModel = LastEngagementsModel.fromJson(response.response!.data);
      emit(SuccessLastEngagementsStates());
    } else {

      emit((FailedLastEngagementStates()));
    }
  }
}