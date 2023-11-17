// import 'dart:convert';
// import 'package:flutter/services.dart';
//
// import 'citymodel.dart';
// import 'model.dart';
//
//
// class GetData{
//   Future<List<CityModel>> readJson() async {
//     final String response = await rootBundle.loadString('assets/json/data.json');
//     final data = await json.decode(response);
//     DataRegionsModel dataModel = DataRegionsModel.fromJson(data);
//     List<CityModel> cityModel = dataModel.cityModel!;
//     return cityModel;
//
//   }
// }