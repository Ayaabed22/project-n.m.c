class ImageSliderModel {
    bool? status;
   String? errNum;
  //late final String msg;
   List<DataImages>? data;
   ImageSliderModel({
      this.errNum,
     this.data,
     this.status
});

  ImageSliderModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    // msg = json['msg'];
    data = List.from(json['data'] ?? []).map((e)=>DataImages.fromJson(e)).toList();
  }
}
class DataImages {
  int? id;
  String? title;
   String? subtitle;
  String? imageUrl;

  DataImages.fromJson(Map<String, dynamic> json){
    id = json['id'] ??' ';
    title = json['title']??'';
    subtitle = json['subtitle']??'';
    imageUrl = json['image_url']??'';
  }
}