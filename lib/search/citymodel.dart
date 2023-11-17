import 'governratemodel.dart';

class CityModel{
  String? id;
  String? name;
  
  CityModel({this.id,this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel( name:json['name'],id:json['id']);}
}

  // CityModel.fromJson(Map<String,dynamic>json){
  //   id=json['id'];
  //   name=json['name'];
  //   // if (json['data'] != null) {
  //   //   regionModel = <RegionsData>[];
  //   //   json['data'].forEach((v) {
  //   //     regionModel.add(RegionsData.fromJson(v));
  //   //   });
  //   // }
  // }
  // Map<String,dynamic> toJson(){
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['id'] = id;
  //   if (regionModel != null)
  //   {
  //     data['data'] = regionModel!.map((v) => v.toJson()).toList();
  //   }
  //
  //   return data;
  // }



