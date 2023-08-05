class LoginResponse {
  final String? date;
  final String? msg;
  final String? message;
  final int? status;
  final Data? data;

  LoginResponse({
    required this.date,
    this.msg,
    required this.message,
    required this.status,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        date: json["date"],
        msg: json["msg"],
        message: json["message"],
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? userName;
  String? name;
  String? email;
  String? address, password;
  int? age;
  dynamic img;
  int? roleId, phoneNumber;
  String? roleName;
  String? jwtToken;

  Data({
    this.id,
    this.phoneNumber,
    this.userName,
    this.name,
    this.email,
    this.password,
    this.address,
    this.age,
    this.img,
    this.roleId,
    this.roleName,
    this.jwtToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userName: json["userName"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        age: json["age"],
        img: json["img"],
        roleId: json["roleId"],
        roleName: json["roleName"],
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "name": name,
        "password": password,
        "email": email,
        "address": address,
        'phoneNumber': phoneNumber,
        "age": age,
        "img": img,
        "roleId": roleId,
      };
}
