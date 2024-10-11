

class DataModel {
  String? name;
  String? age;
  String? image;

  DataModel({
    this.name,
    this.age,
    this.image
  });

  factory DataModel.fromJson(Map<String,dynamic>json){
    return DataModel(
      name: json['name'],
      age: json['age'],
      image: json['image']

    );
  }
  Map<String,dynamic>toJson(){
    return {
      'name': name,
      'age': age,
      'image':image
    };
  }
}
