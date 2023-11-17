class LastEngagementsModel {
  late final bool status;
  late final String errNum;
  late final List<DataModelEngaements> data;

  LastEngagementsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    data = List.from(json['data']).map((e)=>DataModelEngaements.fromJson(e)).toList();
  }

}

class DataModelEngaements {
  late final int id;
  late final String imageUrl;

  DataModelEngaements.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imageUrl = json['image_url'];
  }

}

