import 'dart:io';

class CartData {
  late String? invoicesKey;
  String? fullName;
  String? Address;
  String? DateOfBirth;
  String? nationalId;
  String? phoneNumber;
  String? job;
  String? cardType;
  File? imagePerson;
  String? homePhone;
  String? companyName;
  String? email;
  String? workPlace;
  PersonModel? personModel;

  CartData(
      {this.invoicesKey,
      this.fullName,
      this.Address,
      this.DateOfBirth,
      this.nationalId,
      this.phoneNumber,
      this.job,
      this.cardType,
      this.homePhone,
      this.companyName,
      this.email,
      this.workPlace,
      this.personModel,
      this.imagePerson});
}

class PersonModel {
  String? name;
  String? age;
  String? nationalPersonId;
  String? gender;
  File? image;

  PersonModel(
      {this.name, this.age, this.nationalPersonId, this.gender, this.image});
}
