class PersonDataCart {
   Cart? data;


   PersonDataCart({this.data});

  PersonDataCart.fromJson(Map<String, dynamic> json){
    data = Cart.fromJson(json['data']);
  }
}

class Cart {
  late final String status;
  late final CartModelData cartModelData;

  Cart.fromJson(Map<String, dynamic> json){
    status = json['status'];
    cartModelData = CartModelData.fromJson(json['data']);
  }

}
class CartModelData{
   int? invoiceId;
  String? invoiceKey;
  PaymentDataModel? paymentDataModel=PaymentDataModel();

   CartModelData({this.invoiceId, this.invoiceKey, this.paymentDataModel});

  CartModelData.fromJson(Map<String, dynamic> json){
    invoiceId = json['invoice_id'];
    invoiceKey=json['invoice_key'] ?? '';
    paymentDataModel = PaymentDataModel.fromJson(json['payment_data']);
  }


}

class PaymentDataModel {
   int? mezaReference;
   String? meezaQrCode;
   String? fawryCode;
   String? expireDate;
   int? amanCode;
   int? masaryCode;
   String? redirectTo;

   PaymentDataModel({this.mezaReference, this.meezaQrCode, this.fawryCode,
      this.expireDate, this.amanCode, this.masaryCode, this.redirectTo});

  PaymentDataModel.fromJson(Map<String, dynamic> json){

    mezaReference = json['meezaReference'] ?? 0 ;
    meezaQrCode=json['meezaQrCode'] ?? '';
    fawryCode=json['fawryCode'] ?? '';
    expireDate=json['expireDate'] ?? '';
    amanCode=json['amanCode'] ?? 0;
    masaryCode=json['masaryCode'] ?? 0;
    redirectTo=json['redirectTo'] ?? '';

  }

}
