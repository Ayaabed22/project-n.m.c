class RegionData {
  late final String id;
  late final String governorate_id;
  late final String city_name_ar;
  late final String city_name_en;


  RegionData(this.id, this.governorate_id, this.city_name_ar, this.city_name_en,);


  factory RegionData.fromJson(Map<String, dynamic> json) {
    return RegionData(json['id'], json['governorate_id'],json['city_name_ar'], json['city_name_en'],);}
}



//   RegionsData.fromJson(Map<String, dynamic>json){
//     id = json['id'];
//     governorate_id = json['governorate_id'];
//     city_name_ar = json['city_name_ar'];
//     city_name_en = json['city_name_en'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['governorate_id'] = governorate_id;
//     data['id'] = id;
//     data['city_name_ar'] = city_name_ar;
//     data['city_name_en'] = city_name_en;
//
//     return data;
//   }
// }