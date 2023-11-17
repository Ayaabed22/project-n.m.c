class UserData {
  late final bool status;
  late final String errNum;
  late final Client client;

  UserData.fromJson( dynamic json){
    status = json['status'];
    errNum = json['errNum'];
    client = Client.fromJson(json['client']);
  }
}


class Client {
  late final int id;
  late final String firstName;
  late final String LastName;
  late final String phoneNumber;
  late final String email;
  late final String authToken;

  Client.fromJson(dynamic json){
    id = json['id'] ?? '';
    firstName = json['firstName'] ?? '';
    LastName = json['LastName'] ?? '';
    phoneNumber = json['phoneNumber']?? '';
    email = json['email']?? '';
    authToken = json['authToken']?? '';
  }

  Map toJson() {
    Map<String, dynamic>data = {};
    data['firstName'] = firstName;
    data['id'] = id;
    data['LastName'] = LastName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['authToken'] = authToken;
    return data;
  }

}