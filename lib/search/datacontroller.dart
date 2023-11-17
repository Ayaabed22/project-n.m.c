// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
//
// import 'citymodel.dart';
// import 'get_data.dart';
// import 'governratemodel.dart';
//
// class DataController extends ChangeNotifier {
//   GetData getData = GetData();
//   List<CityModel> _dataModel = [];
//   List<CityModel> get dataModel => _dataModel;
//   final List<RegionsData> regionsData = [];
//   List<RegionsData> get region => regionsData;
//   String regionValue = 'Select';
//   String cityValue = 'Select';
//   void data() async {
//     _dataModel = await getData.readJson();
//     log('message: $_dataModel');
//     log('dataModel :${_dataModel[0].name}');
//     notifyListeners();
//   }
//
//   void updateRegion(String value) {
//     regionValue = value;
//     log('driver value: $regionValue');
//     notifyListeners();
//   }
//
//   void updateCity(String value) {
//     cityValue = value;
//     notifyListeners();
//   }
//
//   void Region() async {
//     for (var i in _dataModel) {
//       log('name=${i.name!}');
//       log('driver=$regionValue');
//       if (i.name == regionValue) {
//         for(var j in i.regionModel){
//           regionsData.add(j);
//         }
//       }
//     }
//     log('city: $regionsData');
//     //log('dataModel :${_workCitys[0].city}');
//   }
//}