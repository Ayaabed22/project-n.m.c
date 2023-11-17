// import 'citymodel.dart';
//
// class DataRegionsModel{
//   List<CityModel>? cityModel;
//
//   DataRegionsModel({this.cityModel});
//
//   DataRegionsModel.fromJson(Map<String, dynamic> json) {
//   if (json['cities'] != null) {
//   cityModel = <CityModel>[];
//   json['cities'].forEach((v) {
//   cityModel!.add(CityModel.fromJson(v));
//   });
//   }
//   }
//
//   Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   if (cityModel != null) {
//   data['cities'] = cityModel!.map((v) => v.toJson()).toList();
//   }
//   return data;
//   }
//   }
