class MedicalNetwokModel {
  late final bool status;
  late final String errNum;
  late final String msg;
  late final List<MedicalData> data;

  MedicalNetwokModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = List.from(json['data']).map((e) => MedicalData.fromJson(e)).toList();
  }

  MedicalNetwokModel();
}

class MedicalData {
  String? serviceProvider;
  late final String category;
  late final String image;
  late final String governorate;
  String? specialization;
  late final String region;
  String? address;
  late final String? hotLine;
  String? appointments;
  late final String? discountPercentage;
  late final int id;

  MedicalData.fromJson(Map<String, dynamic> json) {
    serviceProvider=json['serviceProvider'];
    category = json['category'];
    discountPercentage = json['discountPercentage'];
    address = json['address'];
    appointments= json['appointments'];
    hotLine= json['hotLine'];
    image = json['image'];
    id = json['id'];
    governorate = json['governorate'];
    specialization = json['specialization'];
    region = json['region'];
  }
}