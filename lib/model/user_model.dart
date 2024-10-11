class UserModel {
  String? id;
  String? phoneNumber;

  UserModel({
    this.id,
    this.phoneNumber,
  });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
    );

  }
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'phoneNumber':phoneNumber,
    };
  }
}