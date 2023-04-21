class UserDetails {
  int? id;
  String? name;
  String? email;
  int? age;

  UserDetails({this.id, this.name, this.email, this.age});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    return data;
  }
}
