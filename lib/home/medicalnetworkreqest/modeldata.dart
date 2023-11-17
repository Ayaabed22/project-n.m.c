class MedicalDataNetWorkCategory {
  MedicalDataNetWorkCategory({
     this.status,
    this.errNum,
    this.date,

  });
   bool? status;
   String? errNum;

 List<MedicalNetworkData>? date;

  MedicalDataNetWorkCategory.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    date = List.from(json['date'] ?? []).map((e)=>MedicalNetworkData.fromJson(e)).toList();
  }

}

class MedicalNetworkData {
  MedicalNetworkData({
   this.serviceProvider,
    this.image,
    this.id,
    this.phoneNumber,
    this.address,
    this.discountPercentage,
    this.appointments,
    this.governorate,
    this.region,
    this.phoneNumber2

  });

  String? serviceProvider;
  String? image ;
  String? governorate;
  String?discountPercentage;
  String? region;
  String? address;
  String? phoneNumber;
  String? phoneNumber2;
  String? appointments;
  int? id;


  MedicalNetworkData.fromJson(Map<String, dynamic> json){
    serviceProvider = json['serviceProvider']??'';
    image = json['image'] ?? '';
    region=json['region'] ??'';
    id=json['id'];
    discountPercentage=json['discountPercentage'];
    address=json['address'];
    governorate=json['governorate']??'';
    phoneNumber=json['phoneNumber'];
    phoneNumber2=json['phoneNumber'];
    appointments=json['appointments'];

  }


}
