class ServicesModel {
  late final bool status;
  late final String errNum;
  late final String msg;
  late final List<Data> data;

  ServicesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

}

class Data {
  late final int id;
  late final String title;
  late final String subtitle;
  late final String imageUrl;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    imageUrl = json['image_url'];
  }

}