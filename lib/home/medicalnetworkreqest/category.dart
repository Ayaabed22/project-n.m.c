class CtegoryModel {
  CtegoryModel();
  late final bool status;
  late final String errNum;
  late final List<Data> data;

  CtegoryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }


}

class Data {
  Data();
  late final int id;
  late final String category;
  late final String imageUrl;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    category = json['category'];
    imageUrl = json['image_url'];
  }


}