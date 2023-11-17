class EditProfileModel {

  late final String message;

  EditProfileModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }


}