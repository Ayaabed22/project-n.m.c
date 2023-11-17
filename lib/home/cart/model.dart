class CardData {
  int? id;
  String? state;
  String? fullName;
  String? address;
  String? dateOfBirth;
  String? nationalId;
  String? phoneNumber;
  String? job;
  String? cardType;
  String? imageUrl;
  String? homePhone;
  String? companyName;
  String? email;
  String? workLocation;
  String? created;
  String? deleted;

  CardData({
    this.id,
    this.state,
    this.fullName,
    this.address,
    this.dateOfBirth,
    this.nationalId,
    this.phoneNumber,
    this.job,
    this.cardType,
    this.imageUrl,
    this.homePhone,
    this.companyName,
    this.email,
    this.workLocation,
    this.created,
    this.deleted,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      id: json['id'],
      state: json['state'],
      fullName: json['full_name'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      nationalId: json['national_id'],
      phoneNumber: json['phone_number'],
      job: json['job'],
      cardType: json['card_type'],
      imageUrl: json['image_url'],
      homePhone: json['home_phone'],
      companyName: json['company_name'],
      email: json['email'],
      workLocation: json['work_location'],
      created: json['created'],
      deleted: json['deleted'],
    );
  }
}

class FamilyMember {
  String? name;
  String? age;
  String? nationalId;
  String? gender;
  String? imageUrl;

  FamilyMember({
    this.name,
    this.age,
    this.nationalId,
    this.gender,
    this.imageUrl,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      name: json['name'],
      age: json['age'],
      nationalId: json['national_id'],
      gender: json['gender'],
      imageUrl: json['image_url'],
    );
  }
}

class CardInformation {
  CardData? card;
  List<FamilyMember>? familyMembers;

  CardInformation({
    this.card,
    this.familyMembers,
  });

  factory CardInformation.fromJson(Map<String, dynamic> json) {
    return CardInformation(
      card: CardData.fromJson(json['card'] ),
      familyMembers: List<FamilyMember>.from(
        (json['family_members'] as List<dynamic>).map(
              (member) => FamilyMember.fromJson(member),
        ),
      ),
    );
  }
}

