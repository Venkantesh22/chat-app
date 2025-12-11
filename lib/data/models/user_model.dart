class UserModel {
  String? id;
  String? name;
  String? email;
  String? image;
  String? userName;
  String? searchKey;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.userName,
    this.searchKey,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      userName: json['userName'] as String?,
      searchKey: json['searchKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'userName': userName,
      'searchKey': searchKey,
    };
  }
}
