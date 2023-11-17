class PaymentModel {
  late final modelDataSection data;
  PaymentModel.fromJson(Map<String, dynamic> json){
    data = modelDataSection.fromJson(json['data']);
  }}
class modelDataSection {
  late final String status;
  late final List<PaymentData> payment;
  modelDataSection.fromJson(Map<String, dynamic> json){
    payment = List.from(json['data']).map((e)=>PaymentData.fromJson(e)).toList();
    status=json['status'];
  }}
class PaymentData {
   int? paymentId;
  String? nameEn;
   String? nameAr;
  String? redirect;
  String? logo;

  PaymentData({this.paymentId,this.redirect,this.logo,this.nameAr,this.nameEn});

  PaymentData.fromJson(Map<dynamic, dynamic> json){
     nameEn=json['name_en'];
     nameAr=json['name_ar'];
    redirect=json['redirect'];
    logo=json['logo'];
    paymentId=json['paymentId'];
  }

}


