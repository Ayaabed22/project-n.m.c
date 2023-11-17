class MedicalCategory {
  MedicalCategory({
    this.data,
  });
   List<Medical>? data;

  MedicalCategory.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']??[]).map((e)=>Medical.fromJson(e)).toList();
  }


}

class Medical {
  Medical({
    this.category,
   this.MedicalNetwork,
    this.image,
  });

 String? category;
  int? MedicalNetwork;
  String? image;


  Medical.fromJson(Map<String, dynamic> json){
    category = json['category'] ?? '';
    MedicalNetwork = json['MedicalNetwork']??'';
    image = json['image']??'';

  }


}