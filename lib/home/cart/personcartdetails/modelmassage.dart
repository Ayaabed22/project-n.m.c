class ModelMessage{
  String? massge;
  ModelMessage({this.massge});
  ModelMessage.fromJson(Map<String, dynamic> json){
    massge=json['message'];
  }
}